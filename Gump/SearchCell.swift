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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        cellID = String()
    }
    
    var usernameLabel = DefaultLabel(textColor: signalBlueColor)
    var fullNameLabel = DefaultLabel(textColor: darkPinkColor)
    var cellID = String()
    
    @objc func sendFriendRequestTapped(_ sender:UIButton) {
        
        buttonAction()
    }
    
    var buttonAction: (() -> (Void))!
    
    var viewProfileButton:UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = darkPinkColor
        button.setTitle("View Profile", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 7.5
        
        return button
    }()
    
    func setFunction(_ function: @escaping () -> Void) {
        self.buttonAction = function
    }

    
    func layoutProperties() {
        usernameLabel.font = UIFont(name: "AvenirNext-Bold", size: frame.height / 2.75)
        fullNameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: frame.height / 3)
        
        viewProfileButton.addTarget(self, action: #selector(sendFriendRequestTapped(_:)), for: .touchDown)
        viewProfileButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: frame.height / 3.15)
        
        
    }
    
    func layoutCell() {
        
        addSubview(usernameLabel)
        addSubview(fullNameLabel)
        addSubview(viewProfileButton)
        
        layoutProperties()
        
        usernameLabel.textAlignment = .left
        usernameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width / 27.5).isActive = true
        usernameLabel.bottomAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        fullNameLabel.textAlignment = .left
        fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: -5).isActive = true
        fullNameLabel.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor).isActive = true

        
        viewProfileButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        viewProfileButton.rightAnchor.constraint(equalTo: rightAnchor, constant: frame.width / -27.5).isActive = true
        viewProfileButton.widthAnchor.constraint(equalToConstant: frame.width / 3).isActive = true
        viewProfileButton.leftAnchor.constraint(equalTo: fullNameLabel.rightAnchor, constant: frame.width / 18.5).isActive = true
        
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
