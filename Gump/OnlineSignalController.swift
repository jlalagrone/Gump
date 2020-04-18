//
//  OnlineSignalController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/18/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

class OnlineSignalController: UIViewController {
    
    var mainLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Online Signal"
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
    
    var consoleLabel = DefaultLabel(title: "CONSOLE")
    var gameLabel = DefaultLabel(title: "GAME")
    
    var consoleField = DefaultTextField(color: .white, borderColor: darkPinkColor.cgColor, placeholderText: "Select Console", placeholderLength: 14)
    var gameField = DefaultTextField(color: .white, borderColor: darkPinkColor.cgColor, placeholderText: "Select Game", placeholderLength: 11)
        
    var selectFriendsButton = DefaultButton(backgroundColor: .white, borderColor: darkPinkColor.cgColor, title: "SELECT FRIENDS")
    
    
    func layoutFonts() {
        
        mainLabel.font = UIFont(name: "AvenirNext-Medium", size: view.frame.height / 28)
        consoleLabel.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height / 35)
        gameLabel.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height / 35)
        
        consoleField.textColor = .black
        gameField.textColor = .black
        
        selectFriendsButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: 20)
        selectFriendsButton.setTitleColor(lightBlueColor, for: .normal)
        selectFriendsButton.layer.shadowRadius = 1.5
        selectFriendsButton.layer.shadowOpacity = 1.0
        selectFriendsButton.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        selectFriendsButton.layer.shadowColor = UIColor(white: 0, alpha: 0.75).cgColor
        selectFriendsButton.titleLabel?.layer.shadowColor = UIColor(white: 0, alpha: 0.85).cgColor
        selectFriendsButton.titleLabel?.layer.shadowOpacity = 1.0
        selectFriendsButton.titleLabel?.layer.shadowRadius = 0.5
        selectFriendsButton.titleLabel?.layer.shadowOffset = CGSize(width: 0.5, height: 1)
    }
    
    func layoutView() {
        
        view.backgroundColor = lightPinkColor
        
        view.addSubview(mainLabel)
        view.addSubview(contentView)
        view.addSubview(consoleLabel)
        view.addSubview(consoleField)
        view.addSubview(gameLabel)
        view.addSubview(gameField)
        view.addSubview(selectFriendsButton)
        
        mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 17.5).isActive = true
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: view.frame.height / 27.5).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        
        consoleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        consoleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        consoleField.topAnchor.constraint(equalTo: consoleLabel.bottomAnchor, constant: 5).isActive = true
        consoleField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        consoleField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85).isActive = true
        
        gameLabel.topAnchor.constraint(equalTo: consoleField.bottomAnchor, constant: view.frame.height / 35).isActive = true
        gameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        gameField.topAnchor.constraint(equalTo: gameLabel.bottomAnchor, constant: 5).isActive = true
        gameField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        gameField.widthAnchor.constraint(equalTo: consoleField.widthAnchor).isActive = true
        
        contentView.bottomAnchor.constraint(equalTo: gameField.bottomAnchor, constant: view.frame.height / 25).isActive = true
        
        selectFriendsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectFriendsButton.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        selectFriendsButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: view.frame.height / 15).isActive = true
        selectFriendsButton.heightAnchor.constraint(equalToConstant: view.frame.height / 12.5).isActive = true
        
        
        
        layoutFonts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutView()
        
        selectFriendsButton.layer.cornerRadius = 15
        
        
    }


}
