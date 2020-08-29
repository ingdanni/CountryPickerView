//
//  CountrySelectView.swift
//  terncommerce
//
//  Created by 朱慧平 on 2018/1/30.
//  Copyright © 2018年 terncommerce. All rights reserved.
//

import UIKit

public enum DisplayLanguageType {
    case chinese
    case english
    case spanish
}

struct CountryItem {
	var en: String
	var es: String
	var zh: String
	var locale: String
	var code: Int
	
	var codeString: String {
		"+ \(code)"
	}
}

open class CountrySelectView: UIView {
  
	lazy var listOfCountries: [CountryItem] = {
      return countryCodeJson.map { item in
		return CountryItem(en: item["en"] as! String,
						   es: item["es"] as! String,
						   zh: item["zh"] as! String,
						   locale: item["locale"] as! String,
						   code: item["code"] as! Int)
      }
    }()
	
	var topCountries: [CountryItem] = []
  
    public static let shared = CountrySelectView()
	public var selectedCountryCallBack : ((String, String)->(Void))!
  
    fileprivate var countryTableView = UITableView()
    fileprivate var searchCountries : [CountryItem] = []
    fileprivate var searchBarView = UISearchBar()
    fileprivate var regex = ""
    
    fileprivate var _searchBarPlaceholder: String = "Buscar"
  
    public var searchBarPlaceholder: String {
        get{
            return _searchBarPlaceholder
        }
        set{
            _searchBarPlaceholder = newValue
            searchBarView.placeholder = _searchBarPlaceholder
        }
    }
  
    fileprivate var _countryNameFont: UIFont = UIFont.systemFont(ofSize: 16)
  
    public var countryNameFont:UIFont{
        get{
            return _countryNameFont
        }
        set{
            _countryNameFont = newValue
            countryTableView.reloadData()
        }
    }
  
    fileprivate var _countryPhoneCodeFont: UIFont = UIFont.systemFont(ofSize: 14)
  
    public var countryPhoneCodeFont:UIFont{
        get{
            return _countryPhoneCodeFont
        }
        set{
            _countryPhoneCodeFont = newValue
            countryTableView.reloadData()
        }
    }
  
    fileprivate var _countryNameColor: UIColor = .black
  
    public var countryNameColor:UIColor{
        get{
            return _countryNameColor
        }
        set{
            _countryNameColor = newValue
            countryTableView.reloadData()
        }
    }
  
    fileprivate var _countryPhoneCodeColor: UIColor = .gray
  
    public var countryPhoneCodeColor:UIColor{
        get{
            return _countryPhoneCodeColor
        }
        set{
            _countryPhoneCodeColor = newValue
            countryTableView.reloadData()
        }
    }
  
    fileprivate var _barTintColor:UIColor = .green
  
    public var barTintColor:UIColor{
        get{
            return _barTintColor
        }
        set{
            _barTintColor = newValue
            searchBarView.tintColor = _barTintColor
        }
    }
  
    fileprivate var _displayLanguage : DisplayLanguageType = .english
  
    public var displayLanguage: DisplayLanguageType {
        get {
            return _displayLanguage
        }
        set {
            _displayLanguage = newValue
            countryTableView.reloadData()
        }
    }
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
		
		topCountries = listOfCountries.filter {
			[1, 86, 505, 506, 504].contains($0.code)
		}
		
		searchCountries = listOfCountries
		
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(self.dismiss))
        tap.delegate = self
        self.addGestureRecognizer(tap)
		self.backgroundColor = .white
        self.addSubview(countryTableView)
      
        countryTableView.delegate = self
        countryTableView.dataSource = self
		countryTableView.separatorStyle = .singleLine
		countryTableView.backgroundColor = .white
        
        searchBarView.placeholder = "Buscar"
		searchBarView.backgroundColor = .white
        searchBarView.backgroundImage = UIImage(named: "")
		searchBarView.barTintColor = .white
		searchBarView.tintColor = .white
        searchBarView.showsCancelButton = false
        searchBarView.delegate = self
        searchBarView.frame = CGRect(x: 0, y: 0, width: 0.8 * self.frame.size.width, height: 50)
        
        countryTableView.tableHeaderView = searchBarView
        countryTableView.showsVerticalScrollIndicator = false
        countryTableView.layer.masksToBounds = true
        countryTableView.layer.cornerRadius = 5.0
    }
  
    func setLayout() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        countryTableView.translatesAutoresizingMaskIntoConstraints = false
      
        self.superview!.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy:.equal, toItem:self.superview!, attribute: .width, multiplier:1.0, constant:0.0))
        self.superview!.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy:.equal, toItem:self.superview!, attribute: .height, multiplier:1.0, constant:0.0))
        self.superview!.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy:.equal, toItem:self.superview!, attribute: .centerX, multiplier:1.0, constant:0))
        self.superview!.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy:.equal, toItem:self.superview!, attribute: .centerY, multiplier:1.0, constant:0))
      
      self.addConstraint(NSLayoutConstraint(item: countryTableView, attribute: .width, relatedBy:.equal, toItem:self, attribute: .width, multiplier:1.0, constant: 0))

      self.addConstraint(NSLayoutConstraint(item: countryTableView, attribute: .height, relatedBy:.equal, toItem:self, attribute: .height, multiplier:1.0, constant: 0))
      
        self.addConstraint(NSLayoutConstraint(item: countryTableView, attribute: .centerX, relatedBy:.equal, toItem:self, attribute:.centerX, multiplier:1.0, constant: 0))

        self.addConstraint(NSLayoutConstraint(item: countryTableView, attribute: .centerY, relatedBy:.equal, toItem:self, attribute:.centerY, multiplier:1.0, constant: 0))
    }
  
    public func show() {
        
        if let window = UIApplication.shared.delegate!.window! {
            window.addSubview(self)
        }
      
        searchBarView.text = ""
		searchCountries = listOfCountries
        self.countryTableView.reloadData()
        self.setLayout()
    }
  
    @objc public func dismiss() {
        self.removeFromSuperview()
    }
  
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
	
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
private typealias searchBarDelegate = CountrySelectView
extension searchBarDelegate : UISearchBarDelegate {
	
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
			searchCountries = listOfCountries
            countryTableView.reloadData()
            return
        }
        
        self.getRegexString(searchString: searchText.lowercased())
		
        var results : [CountryItem] = []
		
        for item in listOfCountries {
			if self.checkSearchStringCharHas(compareString: item.zh.lowercased()) || self.checkSearchStringCharHas(compareString: item.en.lowercased().replacingOccurrences(of: " ", with: "")) || self.checkSearchStringCharHas(compareString: item.es.lowercased().replacingOccurrences(of: " ", with: "")) || self.checkSearchStringCharHas(compareString: item.code.description) || self.checkSearchStringCharHas(compareString: item.locale.lowercased().replacingOccurrences(of: " ", with: "")) {
                results.append(item)
            }
        }
		
        searchCountries = results
        countryTableView.reloadData()
    }
	
    func getRegexString(searchString: String){
        var str :String = ""
        let count = searchString.count
        for index in 0..<count {
            let i = searchString.index(searchString.startIndex, offsetBy: index, limitedBy: searchString.endIndex)
            if str.count == 0{
                str = "(^|[a-z0-9\\u4e00-\\u9fa5])+[\(searchString[i!])]"
            }else{
                str = "\(str)+[a-z0-9\\u4e00-\\u9fa5]*[\(searchString[i!])]"
            }
        }
        regex = "\(str)+[a-z0-9\\u4e00-\\u9fa5]*$"
    }
	
    func checkSearchStringCharHas(compareString: String) -> Bool{
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: compareString)
        return isValid
    }
    
}
private typealias tapGestureDelegate = CountrySelectView

extension tapGestureDelegate : UIGestureRecognizerDelegate{
	
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if NSStringFromClass((touch.view?.classForCoder)!).components(separatedBy: ".").last! == "UITableViewCellContentView"{
            return false
        }
        return true
    }
}
private typealias tableViewDelegate = CountrySelectView

// MARK: UITableView Delegate

extension tableViewDelegate : UITableViewDelegate {
	
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selected = indexPath.section == 0 ? topCountries[indexPath.row] : searchCountries[indexPath.row]
		self.selectedCountryCallBack(selected.codeString, selected.es)
        self.dismiss()
    }
}

private typealias tableViewDataSource = CountrySelectView

// MARK: UITableView DataSource

extension tableViewDataSource : UITableViewDataSource {
	
	public func numberOfSections(in tableView: UITableView) -> Int { 2 }
  
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		section == 0
			? (searchBarView.text?.count == 0 ? topCountries.count : 0)
			: searchCountries.count
    }
  
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let indentifier: String = "CountryTableViewCell"

		let cell: CountryTableViewCell! = tableView.dequeueReusableCell(withIdentifier: indentifier) as? CountryTableViewCell ?? CountryTableViewCell(style: .default, reuseIdentifier: indentifier)
		
		let item = indexPath.section == 0 ? topCountries[indexPath.row] : searchCountries[indexPath.row]
    
		cell.countryNameLabel.text = item.es
		cell.countryNameLabel.font = _countryNameFont

		cell.phoneCodeLabel.text = item.codeString
		cell.phoneCodeLabel.font = _countryPhoneCodeFont
		cell.phoneCodeLabel.textColor = _countryPhoneCodeColor
		return cell
    }
  
	public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 50 }
	
}

