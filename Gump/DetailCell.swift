//
//  DetailCell.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/21/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import Foundation
import UIKit

class DetailCell:UITableViewCell {
    
    var titleLabel = DefaultLabel(textColor: .black)
    
    
    
    func layoutView() {
        
        backgroundColor = .white
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        titleLabel.textAlignment = .left
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width / 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
          
        layoutView()
    
          
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
