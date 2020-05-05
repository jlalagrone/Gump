//
//  RequestCell.swift
//  Gump
//
//  Created by Jordan LaGrone on 5/4/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase

class RequestCell:UITableViewCell {
    
    var usernameLabel = DefaultLabel(textColor: .black)
    var fullNameLabel = DefaultLabel(textColor: .black)
    
    var acceptButton:UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = darkPinkColor
        button.setTitle("Accept", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    var denyButton:UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Deny", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    func layoutCell() {
        
        addSubview(usernameLabel)
        addSubview(fullNameLabel)
        addSubview(acceptButton)
        addSubview(denyButton)
        
        
        usernameLabel.text = "Username"
        usernameLabel.numberOfLines = 1
        usernameLabel.textAlignment = .left
        usernameLabel.font = UIFont(name: "AvenirNext-Bold", size: frame.height / 3)
        usernameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width / 22.5).isActive = true
        usernameLabel.bottomAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        fullNameLabel.text = "Full Name"
        fullNameLabel.numberOfLines = 1
        fullNameLabel.textAlignment = .left
        fullNameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: frame.height / 3.25)
        fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor).isActive = true
        fullNameLabel.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor).isActive = true
        
        
        acceptButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        acceptButton.leftAnchor.constraint(equalTo: fullNameLabel.rightAnchor, constant: frame.width / 15).isActive = true
        acceptButton.rightAnchor.constraint(equalTo: denyButton.leftAnchor, constant: -5).isActive = true
        acceptButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.285).isActive = true
        
        denyButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        denyButton.rightAnchor.constraint(equalTo: rightAnchor, constant: frame.width / -20).isActive = true
        
        
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layoutCell()
        
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

}
