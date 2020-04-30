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
    var promoLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: 14)
        label.text = "The best there is, the best there was, the best there ever will be"
        label.numberOfLines = 0
        
        return label
    }()
    
    var onlineLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-Heavy", size: 12)
        
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
        addSubview(promoLabel)
        addSubview(onlineLabel)
            
        backgroundColor = .white
        
        usernameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width/20).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: frame.height/10).isActive = true
    
        
        promoLabel.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor).isActive = true
        promoLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.625).isActive = true
        promoLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor).isActive = true
        
        bottomAnchor.constraint(equalTo: promoLabel.bottomAnchor, constant: 3.5).isActive = true
        
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
