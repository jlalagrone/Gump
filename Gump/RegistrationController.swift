//
//  RegistrationController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/10/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase


class RegistrationController: UIViewController {
    
    var ref:DatabaseReference?
    
    var viewLogo:UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "gumdropLogo")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // Main label that tells user what information to input on the screen
    var mainLabel = DefaultLabel()
    
    var emailField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
    var passwordField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
    var confirmPasswordField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
    
    var usernameField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
    var firstNameField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
    var lastNameField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
    
    var consoleField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
    var gameField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
    
    var continueButton:RegistrationButton = {
        var button = RegistrationButton(backgroundColor: .white, borderColor: UIColor(red: 184.0/255.0, green: 0.0/255.0, blue: 222.0/255.0, alpha: 1).cgColor, title: "Continue")
        
        
        return button
    }()
 

    
    func layoutFonts() {
        
        mainLabel.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: view.frame.height/25)
        continueButton.titleLabel?.font = UIFont(name: "BubbleGum", size: view.frame.height/32)
    }
    
    func layoutInitialView() {
        
        view.addSubview(viewLogo)
        view.addSubview(mainLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(confirmPasswordField)
        view.addSubview(usernameField)
        view.addSubview(firstNameField)
        view.addSubview(lastNameField)
        view.addSubview(consoleField)
        view.addSubview(gameField)
        view.addSubview(continueButton)
        
        mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/15).isActive = true
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.825).isActive = true
        
        emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.825).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: view.frame.height/14.5).isActive = true
        emailField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: view.frame.height/16.5).isActive = true
  
        passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordField.widthAnchor.constraint(equalTo: emailField.widthAnchor).isActive = true
        passwordField.heightAnchor.constraint(equalTo: emailField.heightAnchor).isActive = true
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: view.frame.height/20).isActive = true
        
        confirmPasswordField.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor).isActive = true
        confirmPasswordField.widthAnchor.constraint(equalTo: passwordField.widthAnchor).isActive = true
        confirmPasswordField.heightAnchor.constraint(equalTo: passwordField.heightAnchor).isActive = true
        confirmPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: view.frame.height/20).isActive = true
        
        usernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.825).isActive = true
        usernameField.heightAnchor.constraint(equalToConstant: view.frame.height/14.5).isActive = true
        usernameField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: view.frame.height/16.5).isActive = true
        usernameField.isHidden = true
        
        firstNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstNameField.widthAnchor.constraint(equalTo: usernameField.widthAnchor).isActive = true
        firstNameField.heightAnchor.constraint(equalTo: usernameField.heightAnchor).isActive = true
        firstNameField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: view.frame.height/20).isActive = true
        firstNameField.isHidden = true
        
        lastNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lastNameField.widthAnchor.constraint(equalTo: usernameField.widthAnchor).isActive = true
        lastNameField.heightAnchor.constraint(equalTo: usernameField.heightAnchor).isActive = true
        lastNameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: view.frame.height/20).isActive = true
        lastNameField.isHidden = true
        
        consoleField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        consoleField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.825).isActive = true
        consoleField.heightAnchor.constraint(equalToConstant: view.frame.height/14.5).isActive = true
        consoleField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: view.frame.height/16.5).isActive = true
        consoleField.isHidden = true
        
        gameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gameField.widthAnchor.constraint(equalTo: consoleField.widthAnchor).isActive = true
        gameField.heightAnchor.constraint(equalTo: consoleField.heightAnchor).isActive = true
        gameField.topAnchor.constraint(equalTo: consoleField.bottomAnchor, constant: view.frame.height/20).isActive = true
        gameField.isHidden = true

        
        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        continueButton.widthAnchor.constraint(equalTo: emailField.widthAnchor).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: (view.frame.height / -12.5)).isActive = true
        continueButton.heightAnchor.constraint(equalTo: emailField.heightAnchor, multiplier: 0.975).isActive = true
        
        setPlaceholderTexts()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(red: 255.0/255.0, green: 125.0/255.0, blue: 206.0/255.0, alpha: 1)
        
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Create Account"
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        continueButton.addTarget(self, action: #selector(registerAccount), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        layoutInitialView()
        layoutFonts()
        
        mainLabel.text = "Enter a email and password"
        mainLabel.numberOfLines = 0
        mainLabel.textAlignment = .center
    }

}
