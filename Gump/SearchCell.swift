//
//  SearchCell.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/28/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

class SearchCell:UITableViewCell {
    
    var usernameLabel = DefaultLabel(textColor: signalBlueColor)
    var fullNameLabel = DefaultLabel(textColor: darkPinkColor)
    
    
    func layoutCell() {
        
        addSubview(usernameLabel)
        addSubview(fullNameLabel)
        
        usernameLabel.textAlignment = .left
        usernameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width / 7.5).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: frame.height / 6.5).isActive = true
        
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
              
        backgroundColor = .white
        
        layoutCell()
          
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
