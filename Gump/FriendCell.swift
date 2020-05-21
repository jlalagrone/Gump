//
//  FriendCell.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/16/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import Foundation
import UIKit

class FriendCell:UITableViewCell {
    
    var usernameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        label.textColor = lightBlueColor
        
        
        return label
    }()
//    var promoLabel: UILabel = {
//        var label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: 14)
//        label.numberOfLines = 0
//        label.textColor = .black
//
//        return label
//    }()
    
    var onlineLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-Heavy", size: 15)
        label.textColor = .green
        label.isHidden = true
        
        return label
    }()
    
    var buttonFunc:(() -> (Void))!
    
    @objc func buttonTapped(_ sender:UIButton) {
        buttonFunc()
    }
    
    func setFunction(_ function: @escaping () -> Void) {
        self.buttonFunc = function
    }
    
    func layoutCell() {
        addSubview(usernameLabel)
        addSubview(onlineLabel)
            
        backgroundColor = .white
        
        usernameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width/20).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: frame.height/10).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        bottomAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5).isActive = true
        
//    
//            
//            for friend in FriendSystem.system.friendsList {
//                print("FRIEND ID: \(friend.uid)")
//                
//                if friend.uid == "GJHnopO4nmeKejUwoNZMLI1a2Wq2" {
//                    self.onlineLabel.isHidden = true
//                }
//            }
            
        
        onlineLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        onlineLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: frame.width / -17.5).isActive = true
        onlineLabel.text = "ONLINE"
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
          
        layoutCell()
          
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
