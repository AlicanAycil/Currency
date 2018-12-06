//
//  CurrencyViewCell.swift
//  Currency
//
//  Created by Alican Aycil on 29.11.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CurrencyViewCell: UITableViewCell {
    
    var didSetupConstraints = false
    let screenSize = UIScreen.main.bounds
    lazy var titleLabel = UILabel()
    lazy var valueLabel = UILabel()
    lazy var iconImageView = UIImageView()
    lazy var lineView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        titleLabel.font = AppFont.regular.pt15
        titleLabel.sizeToFit()
        titleLabel.numberOfLines = 0
        self.contentView.addSubview(titleLabel)
        
        valueLabel.font = AppFont.regular.pt15
        valueLabel.sizeToFit()
        valueLabel.numberOfLines = 0
        self.contentView.addSubview(valueLabel)
        
        iconImageView.image = #imageLiteral(resourceName: "stabile.png").withRenderingMode(.alwaysOriginal)
        iconImageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(iconImageView)
        
        lineView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        self.contentView.addSubview(lineView)
        
        self.contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if(!didSetupConstraints){
            
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(30)
                make.centerY.equalTo(self.contentView)
            }
            
            valueLabel.snp.makeConstraints { (make) in
                make.right.equalTo(-65)
                make.centerY.equalTo(self.contentView)
            }
            didSetupConstraints = true
            
            iconImageView.snp.makeConstraints { (make) in
                make.right.equalTo(-30)
                make.centerY.equalTo(self.contentView)
                make.height.equalTo(25)
                make.width.equalTo(25)
            }
            
            lineView.snp.makeConstraints { (make) in
                make.bottom.equalTo(0)
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.height.equalTo(1)
            }
        }
        
        super.updateConstraints()
    }
    
    func set(rate: Rate) {
        titleLabel.text = rate.Title
        valueLabel.text = "\(rate.Value!)"
        if let isUp = rate.isUp {
            self.iconImageView.isHidden = false
            if isUp {
                self.iconImageView.image = #imageLiteral(resourceName: "up.png").withRenderingMode(.alwaysOriginal)
            } else {
                self.iconImageView.image = #imageLiteral(resourceName: "down.png").withRenderingMode(.alwaysOriginal)
            }
        } else {
            self.iconImageView.image = #imageLiteral(resourceName: "stabile.png").withRenderingMode(.alwaysOriginal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
