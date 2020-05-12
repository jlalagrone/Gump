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
    
    var acceptButtonAction: (() -> ((Void)))!
    var declineButtonAction: (() -> ((Void)))!
    
    var acceptButton:UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = darkPinkColor
        button.setTitle("Accept", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        
        return button
    }()
    
    var declineButton:UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Decline", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    func setAcceptFunction(_ function: @escaping () -> Void) {
        self.acceptButtonAction = function
        
    }
    
    func setDeclineFunction(_ function: @escaping () -> Void) {
        
        self.declineButtonAction = function
    }
    
    @objc func requestAcceptedTapped(_ sender:UIButton) {
        
        acceptButtonAction()
        
    }
    
    @objc func requestDeclinedTapped(_ sender:UIButton) {
        
        declineButtonAction()
    }
    
    func layoutCell() {
        
        backgroundColor = .white
        
        addSubview(usernameLabel)
        addSubview(fullNameLabel)
        addSubview(acceptButton)
        addSubview(declineButton)
        
        acceptButton.addTarget(self, action: #selector(requestAcceptedTapped(_:)), for: .touchDown)
        declineButton.addTarget(self, action: #selector(requestDeclinedTapped(_:)), for: .touchDown)
        
//        usernameLabel.text = "Username"
        usernameLabel.numberOfLines = 1
        usernameLabel.textAlignment = .left
        usernameLabel.backgroundColor = .green
        usernameLabel.font = UIFont(name: "AvenirNext-Bold", size: frame.height / 2.75)
        usernameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width / 22.5).isActive = true
        usernameLabel.bottomAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
//        fullNameLabel.text = "Full Name"
        fullNameLabel.numberOfLines = 1
        fullNameLabel.textAlignment = .left
        fullNameLabel.backgroundColor = .yellow
        fullNameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: frame.height / 3)
        fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor).isActive = true
        fullNameLabel.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor).isActive = true
        fullNameLabel.widthAnchor.constraint(equalToConstant: frame.width / 2.15).isActive = true
        
        acceptButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: frame.height / 3.15)
        acceptButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        acceptButton.leftAnchor.constraint(equalTo: fullNameLabel.rightAnchor, constant: frame.width / 17.5).isActive = true
        acceptButton.rightAnchor.constraint(equalTo: declineButton.leftAnchor, constant: -5).isActive = true
        acceptButton.widthAnchor.constraint(equalTo: declineButton.widthAnchor, multiplier: 1.2).isActive = true
        
        declineButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: frame.height / 3.15)
        declineButton.layer.borderWidth = 1.5
        declineButton.layer.borderColor = UIColor.lightGray.cgColor
        declineButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        declineButton.widthAnchor.constraint(equalToConstant: frame.width / 5).isActive = true
        declineButton.rightAnchor.constraint(equalTo: rightAnchor, constant: frame.width / -15).isActive = true
        
        
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layoutCell()
        
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

}
