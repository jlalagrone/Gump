//
//  RegistrationExt.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/11/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegistrationButton:UIButton {
    
    var ref:DatabaseReference?
    
    init(backgroundColor:UIColor,borderColor:CGColor,title:String) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), for: .normal)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        layer.borderWidth = 2
        layer.borderColor = borderColor
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
}


extension RegistrationController {
   
    func setPlaceholderTexts() {
        
        var emailPlaceholder = NSMutableAttributedString()
        emailPlaceholder = NSMutableAttributedString(string:"Email", attributes: [NSAttributedString.Key.font:UIFont(name: "AvenirNext-Medium", size: 16.5)!])
        emailPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range:NSRange(location:0,length:5))
        
        emailField.attributedPlaceholder = emailPlaceholder
        
        var passwordPlaceholder = NSMutableAttributedString()
        passwordPlaceholder = NSMutableAttributedString(string:"Password", attributes: [NSAttributedString.Key.font:UIFont(name: "AvenirNext-Medium", size: 16.5)!])
        passwordPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range:NSRange(location:0,length:8))
        
        passwordField.attributedPlaceholder = passwordPlaceholder
        
        var confirmPasswordPlaceholder = NSMutableAttributedString()
        confirmPasswordPlaceholder = NSMutableAttributedString(string:"Re-Enter Password", attributes: [NSAttributedString.Key.font:UIFont(name: "AvenirNext-Medium", size: 16.5)!])
        confirmPasswordPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range:NSRange(location:0,length:17))
        
        confirmPasswordField.attributedPlaceholder = confirmPasswordPlaceholder
        
        var usernamePlaceholder = NSMutableAttributedString()
        usernamePlaceholder = NSMutableAttributedString(string:"Username", attributes: [NSAttributedString.Key.font:UIFont(name: "AvenirNext-Medium", size: 16.5)!])
        usernamePlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range:NSRange(location:0,length:8))
        
        usernameField.attributedPlaceholder = usernamePlaceholder
        
        var firstNamePlaceholder = NSMutableAttributedString()
        firstNamePlaceholder = NSMutableAttributedString(string:"First", attributes: [NSAttributedString.Key.font:UIFont(name: "AvenirNext-Medium", size: 16.5)!])
        firstNamePlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range:NSRange(location:0,length:5))
        
        firstNameField.attributedPlaceholder = firstNamePlaceholder
        
        var lastNamePlaceholder = NSMutableAttributedString()
        lastNamePlaceholder = NSMutableAttributedString(string:"Last", attributes: [NSAttributedString.Key.font:UIFont(name: "AvenirNext-Medium", size: 16.5)!])
        lastNamePlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range:NSRange(location:0,length:4))
        
        lastNameField.attributedPlaceholder = lastNamePlaceholder
        
        var consolePlaceholder = NSMutableAttributedString()
        consolePlaceholder = NSMutableAttributedString(string:"Console", attributes: [NSAttributedString.Key.font:UIFont(name: "AvenirNext-Medium", size: 16.5)!])
        consolePlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range:NSRange(location:0,length:7))
        
        consoleField.attributedPlaceholder = consolePlaceholder
        
        var gamePlaceholder = NSMutableAttributedString()
        gamePlaceholder = NSMutableAttributedString(string:"Game", attributes: [NSAttributedString.Key.font:UIFont(name: "AvenirNext-Medium", size: 16.5)!])
        gamePlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range:NSRange(location:0,length:4))
        
        gameField.attributedPlaceholder = gamePlaceholder
        
    }
    
    
    
    
    // Method that creates a FirebaseAuth account with user's email & password and other information
    @objc func registerAccount(_ sender:UIButton) {
        ref = Database.database().reference()

        sender.tag += 1
        print("SENDER TAG: \(sender.tag)")
        
        if sender.tag == 3 { sender.tag = 0 }
        
        switch sender.tag {
        case 1:
            guard passwordField.text! == confirmPasswordField.text else {
                print("Passwords don't match")
                sender.tag = 0
                return
            }
            
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (result, error) in
                
                if error != nil {
                    let alert = UIAlertController(title: "There's an issue!", message: error!.localizedDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Continue", style: .default)
                    alert.addAction(alertAction)
                    self.present(alert, animated: false, completion: {
                        sender.tag = 0
                    })
                    
                }
                else {
                    
                    self.ref?.child("Users").child(Auth.auth().currentUser!.uid).setValue(["email": self.emailField.text!, "password": self.passwordField.text!, "uid": Auth.auth().currentUser?.uid])
                    print("Account created!")
                    
                    Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!) { (result, error) in
                        
                        if error != nil {
                            let alert = UIAlertController(title: "Couldn't sign in", message: error!.localizedDescription, preferredStyle: .alert)
                            let alertAction = UIAlertAction(title: "Continue", style: .default)
                            alert.addAction(alertAction)
                        
                            self.present(alert, animated: false, completion: nil)
                        }
                        else {
                            
                            print(Auth.auth().currentUser!.uid)
                            self.emailField.isHidden = true
                            self.passwordField.isHidden = true
                            self.confirmPasswordField.isHidden = true
                            self.emailField.text = nil
                            self.passwordField.text = nil
                            self.confirmPasswordField.text = nil
                            
                            self.mainLabel.text = "Enter your name and desired username"
                            self.usernameField.isHidden = false
                            self.firstNameField.isHidden = false
                            self.lastNameField.isHidden = false
                            self.navigationItem.setHidesBackButton(true, animated: false)
                        }
                    }
                }
            }
        case 2:
            print("Button on second instance")
        default:
            print("Ok")
        }
        
    }
    
    
    
}
