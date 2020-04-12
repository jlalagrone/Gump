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
        
    var continueButton:RegistrationButton = {
        var button = RegistrationButton(backgroundColor: .white, borderColor: UIColor(red: 184.0/255.0, green: 0.0/255.0, blue: 222.0/255.0, alpha: 1).cgColor, title: "Continue")
        
        
        return button
    }()
 
    func setPlaceholderTexts() {
        
        var emailPlaceholder = NSMutableAttributedString()
        emailPlaceholder = NSMutableAttributedString(string:"Email", attributes: [NSAttributedString.Key.font:UIFont(name: "AvenirNext-Medium", size: 16.5)!])
        emailPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range:NSRange(location:0,length:5))
        
        emailField.textAlignment = .center
        emailField.attributedPlaceholder = emailPlaceholder
        
        var passwordPlaceholder = NSMutableAttributedString()
        passwordPlaceholder = NSMutableAttributedString(string:"Password", attributes: [NSAttributedString.Key.font:UIFont(name: "AvenirNext-Medium", size: 16.5)!])
        passwordPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range:NSRange(location:0,length:8))
        
        passwordField.textAlignment = .center
        passwordField.attributedPlaceholder = passwordPlaceholder
        
        var confirmPasswordPlaceholder = NSMutableAttributedString()
        confirmPasswordPlaceholder = NSMutableAttributedString(string:"Re-Enter Password", attributes: [NSAttributedString.Key.font:UIFont(name: "AvenirNext-Medium", size: 16.5)!])
        confirmPasswordPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range:NSRange(location:0,length:17))
        
        confirmPasswordField.textAlignment = .center
        confirmPasswordField.attributedPlaceholder = confirmPasswordPlaceholder
        
    }
    
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
