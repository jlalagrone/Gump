//
//  SignalController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/18/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

class SignalController: UIViewController, UITextViewDelegate {
    
    var mainLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        
        return label
    }()
    
    var contentView:UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = darkPinkColor
        view.layer.cornerRadius = 7.5
        
        return view
    }()
    
    var consoleLabel = DefaultLabel(title: "Console")
    var gameLabel = DefaultLabel(title: "Game")
    var messageLabel = DefaultLabel(title: "Message")
    
    var consoleField = DefaultTextField(color: .white, borderColor: darkPinkColor.cgColor, placeholderText: "Select Console", placeholderLength: 14)
    var gameField = DefaultTextField(color: .white, borderColor: darkPinkColor.cgColor, placeholderText: "Select Game", placeholderLength: 11)
    
    
    // Code that customizes the messageField when creating an invite signal
    var messageField:UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        
        let customToolbar:() -> (UIToolbar) = {
            var toolbar = UIToolbar()
            toolbar.translatesAutoresizingMaskIntoConstraints = false
            toolbar.sizeToFit()
            
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: #selector(hideKeyboard))
            
            toolbar.setItems([flexibleSpace,doneButton], animated: false)
            toolbar.isUserInteractionEnabled = true
            
            return toolbar
           
        }
        
        textView.inputAccessoryView = customToolbar()
        
        return textView
    }()

        
    var selectFriendsButton = DefaultButton(backgroundColor: darkPinkColor, borderColor: UIColor.clear.cgColor, title: "CONTINUE")
    var selectFriendButton = DefaultButton(backgroundColor: darkPinkColor, borderColor: UIColor.clear.cgColor, title: "CONTINUE")
    
    
    func layoutFonts() {
        
        mainLabel.font = UIFont(name: "AvenirNext-Medium", size: view.frame.height / 28)
        consoleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: view.frame.height / 35)
        gameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: view.frame.height / 35)
        messageLabel.font = UIFont(name: "AvenirNext-DemiBold", size: view.frame.height / 35)
        
        messageField.font = UIFont(name: "AvenirNext-DemiBold", size: view.frame.height / 47.5)
        consoleField.font = UIFont(name: "AvenirNext-DemiBold", size: view.frame.height / 47.5)
        consoleField.textColor = .black
        gameField.textColor = .black
        gameField.font = UIFont(name: "AvenirNext-DemiBold", size: view.frame.height / 47.5)
        messageField.textColor = .black
        
        selectFriendsButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height / 35)
        selectFriendsButton.setTitleColor(.white, for: .normal)

        selectFriendButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height / 35)
        selectFriendButton.setTitleColor(.white, for: .normal)

    }
    
    func layoutOnlineSignalView() {
                
        view.addSubview(mainLabel)
        view.addSubview(contentView)
        view.addSubview(consoleLabel)
        view.addSubview(consoleField)
        view.addSubview(gameLabel)
        view.addSubview(gameField)
        view.addSubview(selectFriendsButton)
        
        mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 12.5).isActive = true
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: view.frame.height / 27.5).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        
        consoleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        consoleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        consoleField.topAnchor.constraint(equalTo: consoleLabel.bottomAnchor, constant: 5).isActive = true
        consoleField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        consoleField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85).isActive = true
        consoleField.heightAnchor.constraint(equalToConstant: view.frame.height / 18.5).isActive = true
        
        gameLabel.topAnchor.constraint(equalTo: consoleField.bottomAnchor, constant: view.frame.height / 35).isActive = true
        gameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        gameField.topAnchor.constraint(equalTo: gameLabel.bottomAnchor, constant: 5).isActive = true
        gameField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        gameField.widthAnchor.constraint(equalTo: consoleField.widthAnchor).isActive = true
        gameField.heightAnchor.constraint(equalTo: consoleField.heightAnchor).isActive = true
        
        contentView.bottomAnchor.constraint(equalTo: gameField.bottomAnchor, constant: view.frame.height / 25).isActive = true
        
        selectFriendsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectFriendsButton.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        selectFriendsButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: view.frame.height / 15).isActive = true
        selectFriendsButton.heightAnchor.constraint(equalToConstant: view.frame.height / 13.5).isActive = true
        
    
    }
    
    func layoutInviteSignalView() {
        
        view.addSubview(mainLabel)
        view.addSubview(contentView)
        view.addSubview(gameLabel)
        view.addSubview(gameField)
        view.addSubview(messageLabel)
        view.addSubview(messageField)
        view.addSubview(selectFriendButton)
        
        mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 12.5).isActive = true
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: view.frame.height / 27.5).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        
        gameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        gameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        gameField.heightAnchor.constraint(equalToConstant: view.frame.height / 18.5).isActive = true
        gameField.topAnchor.constraint(equalTo: gameLabel.bottomAnchor, constant: 5).isActive = true
        gameField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        gameField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: gameField.bottomAnchor, constant: view.frame.height / 35).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        
        messageField.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 5).isActive = true
        messageField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        messageField.widthAnchor.constraint(equalTo: gameField.widthAnchor).isActive = true
        messageField.heightAnchor.constraint(equalToConstant: view.frame.height / 7.5).isActive = true
        messageField.textAlignment = .left
        
        contentView.bottomAnchor.constraint(equalTo: messageField.bottomAnchor, constant: view.frame.height / 30).isActive = true
        
        selectFriendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectFriendButton.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        selectFriendButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: view.frame.height / 23.5).isActive = true
        selectFriendButton.heightAnchor.constraint(equalToConstant: view.frame.height / 13.5).isActive = true
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = lightPinkColor

        layoutFonts()
        selectFriendsButton.layer.cornerRadius = 15
        selectFriendButton.layer.cornerRadius = 15
        
        selectFriendButton.addTarget(self, action: #selector(chooseFriendToInvite(_:)), for: .touchDown)
        selectFriendsButton.addTarget(self, action: #selector(chooseFriends(_:)), for: .touchDown)
        
        messageField.delegate = self
    }


}
