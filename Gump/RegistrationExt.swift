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
        
    }
    
    
    
    
    // Method that creates a FirebaseAuth account with user's email & password and other information
    @objc func registerAccount(_ sender:UIButton) {
        let usersRef = Database.database().reference().child("Users")
        ref = Database.database().reference()

        sender.tag += 1
        print("SENDER TAG: \(sender.tag)")
        
        if sender.tag == 4 { sender.tag = 0 }
    
        
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
                    
                    self.ref?.child("Users").child(Auth.auth().currentUser!.uid).setValue(["email": self.emailField.text!, "password": self.passwordField.text!, "uid": Auth.auth().currentUser?.uid, "username": "n/a"])
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
            
            // Checks if firstName & lastName textfields are left blank and runs code inside of else block if they are
            guard self.firstNameField.text! != "" && self.lastNameField.text != "" else {
                print("Please enter your name")
                sender.tag = 1
                
                let alert = UIAlertController(title: "Uh oh!", message: "Please enter your first and last name.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Continue", style: .default)
                alert.addAction(alertAction)
                present(alert, animated: true, completion: nil)
                
                return
            }
            
            // Checks to see if the desired username has been registered already
            usersRef.queryOrdered(byChild: "username").queryEqual(toValue: self.usernameField.text!).observeSingleEvent(of: .value , with: { snapshot in
                 
                
                if !snapshot.exists() {
                    if self.usernameField.text! == "" {
                        
                        // Code thats ran if username field is left blank
                        sender.tag = 1
                        let alert = UIAlertController(title: "Uh oh!", message: "Please enter a username.", preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "Continue", style: .default)
                        alert.addAction(alertAction)
                        self.present(alert, animated: true, completion: nil)
                        
                        return
                    }
                    
                    else if self.usernameField.text!.contains(" ") == true {
                        
                        // Code thats ran if desired username contains spaces
                        sender.tag = 1
                        let alert = UIAlertController(title: "Uh oh!", message: "Please choose a username that does not contain any spaces.", preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "Continue", style: .default)
                        alert.addAction(alertAction)
                        self.present(alert, animated: true, completion: nil)
                        
                        return
                    }
      
                    else {
                    
                        // What happens if username is avialable for use
                        let alert = UIAlertController(title: "Almost Done!", message: "Your name is how other users will determine who you are. Once you've sumbitted your name you can't change it so make sure it's correct!", preferredStyle: .alert)
                        let alertActionNo = UIAlertAction(title: "Go Back", style: .destructive)
                        
                        // Code that executes if user confirms their name and username
                        let alertAction = UIAlertAction(title: "Proceed", style: .default) { (action) in
                            
                            print("Hey \(self.firstNameField.text!) \(self.lastNameField.text!), your username is \(self.usernameField.text!)")
                            usersRef.child(Auth.auth().currentUser!.uid).updateChildValues(["username": self.usernameField.text!, "firstName": self.firstNameField.text!, "lastName": self.lastNameField.text!])
                            
                            self.usernameField.isHidden = true
                            self.usernameField.text = nil
                            self.firstNameField.isHidden = true
                            self.firstNameField.text = nil
                            self.lastNameField.isHidden = true
                            self.lastNameField.text = nil
                            
                            self.consoleField.isHidden = false
                            self.secondaryLabel.isHidden = false
                            self.micField.isHidden = false
                            self.mainLabel.text = "Enter your primary gaming console"
                        }
                        alert.addAction(alertActionNo)
                        alert.addAction(alertAction)
                        
                        self.present(alert, animated: true, completion: nil)
                        
                        }
                    }
                
                else {
                    
                    // Code thats ran if desired username isn't available for use
                        print("That username isn't avaiable, please chooser another!")
                        sender.tag = 1
                    
                        let alert = UIAlertController(title: "Uh oh!", message: "That username has already been taken, please choose another.", preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "Continue", style: .default)
                        alert.addAction(alertAction)
                        self.present(alert, animated: true, completion: nil)
                    
                        return
                    }
        
                })
            
            print("Button on second instance")
            
        case 3:
            print("Button on third instance")
            
            guard consoleField.text! != "" || micField.text! != "" else {
                print("You left a field blank!")
                sender.tag = 2
                
                let alert = UIAlertController(title: "Uh oh!", message: "Please provide your primary gaming console and if you have a microphone or not.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Continue", style: .default)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
                
                return
            }
  
 
            ref?.child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(["console": consoleField.text!, "mic": micField.text!])
            
            
            
            
        
        default:
            print("Ok")
        }
        
    }
    
    
    
}
