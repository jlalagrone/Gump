//
//  SignalController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/18/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

var gamePickerOptions = [String]()
var gamePicker = UIPickerView()
var chosenGame = String()

class SignalController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
        
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return   FriendSystem.system.gameList.count
           
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           
        if !FriendSystem.system.gameList.isEmpty {
        
            chosenGame = FriendSystem.system.gameList[row]
            gameField.text = chosenGame
            
            }
        
        else {
            print("Nothing to show here.")
        }
        

       }
    
       func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
           
        var attributedString:NSAttributedString!
           
        attributedString = NSAttributedString(string: FriendSystem.system.gameList[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
           return attributedString
           
       }
    
    
    var mainLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        
        return label
    }()
    
    var dividerView:UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray

        return view
    }()
    
    var consoleLabel = DefaultLabel(title: "Console")
    var gameLabel = DefaultLabel(title: "Game")
    var messageLabel = DefaultLabel(title: "Message")
    
    var consoleField = DefaultTextField(color: .white, borderColor: UIColor.white.cgColor, placeholderText: "Tap To Type", placeholderLength: 11)
    var gameField = DefaultTextField(color: .white, borderColor: UIColor.white.cgColor, placeholderText: "Tap To Enter", placeholderLength: 12)
    
    
    // Code that customizes the messageField when creating an invite signal
    var messageField:UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.text = "Tap To Type"
        textView.textColor = .lightGray
        
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
    var selectFriendButton = DefaultButton(backgroundColor: darkPinkColor, borderColor: UIColor.clear.cgColor, title: "Tap To Continue")
    
    
    func layoutFonts() {
        
        mainLabel.font = UIFont(name: "AvenirNext-Medium", size: view.frame.height / 28)
        consoleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: view.frame.height / 35)
        gameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: view.frame.height / 35)
        messageLabel.font = UIFont(name: "AvenirNext-DemiBold", size: view.frame.height / 35)
        
        messageField.font = UIFont(name: "AvenirNext-DemiBold", size: view.frame.height / 35)
        consoleField.font = UIFont(name: "AvenirNext-DemiBold", size: view.frame.height / 35)
        consoleField.textColor = .black
        gameField.textColor = .black
        gameField.font = UIFont(name: "AvenirNext-DemiBold", size: view.frame.height / 35)
        
        selectFriendsButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height / 35)
        selectFriendsButton.setTitleColor(.white, for: .normal)

        selectFriendButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height / 35)
        selectFriendButton.setTitleColor(.white, for: .normal)

    }
    
    func layoutOnlineSignalView() {
        
        view.addSubview(gameLabel)
        view.addSubview(gameField)
        view.addSubview(dividerView)
        view.addSubview(consoleLabel)
        view.addSubview(consoleField)
        view.addSubview(selectFriendsButton)
        
        gameLabel.textColor = lightPinkColor
        gameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width / 30).isActive = true
        gameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 35).isActive = true
        
        gameField.topAnchor.constraint(equalTo: gameLabel.bottomAnchor).isActive = true
        gameField.leftAnchor.constraint(equalTo: gameLabel.leftAnchor).isActive = true
        gameField.widthAnchor.constraint(equalToConstant: view.frame.width / 1.15).isActive = true
        gameField.textAlignment = .left
        
        dividerView.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        dividerView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        dividerView.topAnchor.constraint(equalTo: gameField.bottomAnchor, constant: 2.5).isActive = true
        dividerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        consoleLabel.textColor = lightPinkColor
        consoleLabel.leftAnchor.constraint(equalTo: gameLabel.leftAnchor).isActive = true
        consoleLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: view.frame.height / 35).isActive = true
        
        consoleField.topAnchor.constraint(equalTo: consoleLabel.bottomAnchor).isActive = true
        consoleField.leftAnchor.constraint(equalTo: gameLabel.leftAnchor).isActive = true
        consoleField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: view.frame.width / -15).isActive = true
    
        selectFriendsButton.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        selectFriendsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        selectFriendsButton.heightAnchor.constraint(equalToConstant: view.frame.height / 7.5).isActive = true
        selectFriendsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectFriendsButton.titleLabel?.textAlignment = .center
    }
    
    func layoutInviteSignalView() {
        
        view.addSubview(gameLabel)
        view.addSubview(gameField)
        view.addSubview(dividerView)
        view.addSubview(messageLabel)
        view.addSubview(messageField)
        view.addSubview(selectFriendButton)
        
        gameLabel.textColor = lightPinkColor
        gameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width / 30).isActive = true
        gameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 35).isActive = true
        
        gameField.topAnchor.constraint(equalTo: gameLabel.bottomAnchor).isActive = true
        gameField.leftAnchor.constraint(equalTo: gameLabel.leftAnchor).isActive = true
        gameField.widthAnchor.constraint(equalToConstant: view.frame.width / 1.15).isActive = true
        gameField.textAlignment = .left
        
        dividerView.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        dividerView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        dividerView.topAnchor.constraint(equalTo: gameField.bottomAnchor, constant: 2.5).isActive = true
        dividerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        messageLabel.textColor = lightPinkColor
        messageLabel.leftAnchor.constraint(equalTo: gameLabel.leftAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: view.frame.height / 35).isActive = true
        
        messageField.topAnchor.constraint(equalTo: messageLabel.bottomAnchor).isActive = true
        messageField.leftAnchor.constraint(equalTo: gameLabel.leftAnchor).isActive = true
        messageField.heightAnchor.constraint(equalToConstant: view.frame.height / 4).isActive = true
        messageField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        selectFriendButton.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        selectFriendButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        selectFriendButton.heightAnchor.constraint(equalToConstant: view.frame.height / 7.5).isActive = true
        selectFriendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectFriendButton.titleLabel?.textAlignment = .center
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        gamePickerOptions = FriendSystem.system.gameList
        print("Current games are \(gamePickerOptions)")
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FriendSystem.system.getCurrentGumpUser { (user) in

            if let gamesDict = user.games {
                let games = Array(gamesDict.values)
                FriendSystem.system.gameList = games
            }
            
        }
        
        view.backgroundColor = .white

        layoutFonts()
        selectFriendsButton.layer.cornerRadius = 2.5
        selectFriendButton.layer.cornerRadius = 2.5
        
        selectFriendButton.addTarget(self, action: #selector(chooseFriendToInvite(_:)), for: .touchDown)
        selectFriendsButton.addTarget(self, action: #selector(chooseFriends(_:)), for: .touchDown)
        gameField.addTarget(self, action: #selector(showEmptyGameLibraryAlert(_:)), for: .touchDown)
        
        messageField.delegate = self
        
        gamePicker.delegate = self
        gameField.inputView = gamePicker
        gamePicker.backgroundColor = .white
    }


}
