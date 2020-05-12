//
//  SearchCell.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/28/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import Firebase
import UIKit

class SearchCell:UITableViewCell {
    
    var usernameLabel = DefaultLabel(textColor: signalBlueColor)
    var fullNameLabel = DefaultLabel(textColor: darkPinkColor)
    
    @objc func sendFriendRequestTapped(_ sender:UIButton) {
        
        buttonAction()
    }
    
    var buttonAction: (() -> (Void))!
    
    var sendRequestButton:UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = darkPinkColor
        button.setTitle("Send Request", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        
        return button
    }()
    
    func setFunction(_ function: @escaping () -> Void) {
        self.buttonAction = function
    }

    
    func layoutProperties() {
        usernameLabel.font = UIFont(name: "AvenirNext-Bold", size: frame.height / 2.75)
        fullNameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: frame.height / 3)
        
        sendRequestButton.addTarget(self, action: #selector(sendFriendRequestTapped(_:)), for: .touchDown)
        sendRequestButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: frame.height / 3.15)
        
        
    }
    
    func layoutCell() {
        
        addSubview(usernameLabel)
        addSubview(fullNameLabel)
        addSubview(sendRequestButton)
        
        layoutProperties()
        
        usernameLabel.textAlignment = .left
        usernameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width / 22.5).isActive = true
        usernameLabel.bottomAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        fullNameLabel.textAlignment = .left
        fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor).isActive = true
        fullNameLabel.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor).isActive = true
        fullNameLabel.widthAnchor.constraint(equalToConstant: frame.width / 2.15).isActive = true

        
        sendRequestButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        sendRequestButton.rightAnchor.constraint(equalTo: rightAnchor, constant: frame.width / -22.5).isActive = true
        sendRequestButton.widthAnchor.constraint(equalToConstant: frame.width / 2.75).isActive = true
        sendRequestButton.leftAnchor.constraint(equalTo: fullNameLabel.rightAnchor, constant: frame.width / 17.5).isActive = true
        
        bottomAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: frame.height / 3).isActive = true
        
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
