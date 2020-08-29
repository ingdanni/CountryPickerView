//
//  CountryTableViewCell.swift
//  terncommerce
//
//  Created by 朱慧平 on 2018/1/30.
//  Copyright © 2018年 terncommerce. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    var phoneCodeLabel: UILabel!
    var countryNameLabel: UILabel!
//    var countryImageView: UIImageView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }
	
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      
//        countryImageView = UIImageView()
//        self.contentView.addSubview(countryImageView)
//        countryImageView.translatesAutoresizingMaskIntoConstraints = false
//      countryImageView.addConstraint(NSLayoutConstraint(item: countryImageView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1.0, constant: 20))
//        countryImageView.addConstraint(NSLayoutConstraint(item: countryImageView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1.0, constant: 30))
//        self.contentView.addConstraint(NSLayoutConstraint(item:countryImageView!,attribute:.left, relatedBy:.equal, toItem:self.contentView, attribute:.left, multiplier:1.0, constant: 10))
//
//        self.contentView.addConstraint(NSLayoutConstraint(item: countryImageView!, attribute: .centerY, relatedBy:.equal, toItem:self.contentView, attribute:.centerY, multiplier:1.0, constant: 0))
//
//        countryImageView.layer.cornerRadius = 10
      
        phoneCodeLabel = UILabel()
        phoneCodeLabel.textAlignment = .right
        phoneCodeLabel.font = UIFont.systemFont(ofSize: 16)
        phoneCodeLabel.textColor = .gray
        self.contentView.addSubview(phoneCodeLabel)
        phoneCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneCodeLabel.addConstraint(NSLayoutConstraint(item: phoneCodeLabel!, attribute: .height, relatedBy: .equal, toItem: nil, attribute:NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 30))
        phoneCodeLabel.addConstraint(NSLayoutConstraint(item: phoneCodeLabel!, attribute: .width, relatedBy: .equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1.0, constant: 50))
        self.contentView.addConstraint(NSLayoutConstraint(item: phoneCodeLabel!, attribute: .centerY, relatedBy:.equal, toItem:self.contentView, attribute: .centerY, multiplier: 1.0, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: phoneCodeLabel!, attribute:.right, relatedBy:.equal, toItem: self.contentView, attribute: .right, multiplier: 1.0, constant: -10))
        
        countryNameLabel = UILabel()
        countryNameLabel.textAlignment = .left
        countryNameLabel.font = UIFont.systemFont(ofSize: 18)
        self.contentView.addSubview(countryNameLabel)
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        countryNameLabel.addConstraint(NSLayoutConstraint(item: countryNameLabel!, attribute: .height, relatedBy: .equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1.0, constant: 30))
        countryNameLabel.addConstraint(NSLayoutConstraint(item: countryNameLabel!, attribute: .width, relatedBy: .equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1.0, constant: self.contentView.frame.size.width-20-90))
        self.contentView.addConstraint(NSLayoutConstraint(item: countryNameLabel!, attribute: .centerY, relatedBy:.equal, toItem:self.contentView, attribute:.centerY, multiplier:1.0, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: countryNameLabel!,attribute: .left, relatedBy:.equal, toItem:self.contentView, attribute:.left, multiplier: 1.0, constant: 16))
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
