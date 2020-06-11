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


// Custom UIButton subclass object that contains logic that creates a new user and signs in them in
class RegistrationButton:UIButton {
    
    var ref:DatabaseReference?
    
    // Custom initializer with pre-set properties for creating a RegistrationButton object
    init(backgroundColor:UIColor,borderColor:CGColor,title:String) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(signalBlueColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        layer.borderWidth = 3
        layer.borderColor = borderColor
        layer.cornerRadius = 15
        addTarget(self, action: #selector(animateButton(_:)), for: .touchDown)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Animation Code
    func registrationButtonAnimation(text:String?,label:UILabel,viewsToHide: [UIView],viewsToShow: [UIView], completion:() -> ()) {
        
        UIView.animate(withDuration: 0.05, animations: {
            
                label.alpha = 0
                for view in viewsToHide {
                    view.alpha = 0
                    view.removeFromSuperview()
            
                }
            
            }) { (bool) in
            
                UIView.animate(withDuration: 1, animations: {
                
                    label.alpha = 1
                    label.text = text
                
                    }) { (bool) in
                        for view in viewsToShow {
                            view.isHidden = false
                            view.alpha = 0
                    
                            UIView.animate(withDuration: 1.15) {
                                view.alpha = 1
                            }
                        }
                    }
                }
        
            }
        }


extension RegistrationController {
    
    // Method that creates a FirebaseAuth account with user's email & password and other information
    @objc func registerAccount(_ sender:RegistrationButton) {
   
//        let usersRef = Database.database().reference().child("Users")
        ref = Database.database().reference()

//        let finishedVC = UserCreatedController()
        
        sender.tag += 1
        print("SENDER TAG: \(sender.tag)")
        
        if sender.tag > 2 { sender.tag = 0 }
        
        switch sender.tag {
        case 1:

            // Code executed if email or password fields are left blank
            guard emailField.text!.contains("@") && !passwordField.text!.isEmpty && !confirmPasswordField.text!.isEmpty else {
                showAlert(message: "Please enter a valid email and password.")
                
                sender.tag = 0
                return
            }
            
            // Code if password fields aren't identical
            guard passwordField.text! == confirmPasswordField.text else {
                 print("Passwords don't match")
                let alert = UIAlertController(title: "Uh oh!", message: "Your passwords don't match.", preferredStyle: .alert)
                
                let alertAction = UIAlertAction(title: "Continue", style: .default)
                alert.addAction(alertAction)
                self.showAlert(message: "Your passwords don't match!")
                sender.tag = 0
                
                 return
             }
            
            signUpEmail = emailField.text!
            signUpPassword = passwordField.text!
            
            print("Email: \(signUpEmail) \nPassword: \(signUpPassword)")
            
            sender.registrationButtonAnimation(text:"Please enter your desired Gump username and name",label:self.mainLabel,viewsToHide: [self.emailField,self.passwordField,self.confirmPasswordField,self.hideTextButton], viewsToShow: [self.usernameField,self.firstNameField,self.lastNameField]) {
                
                //Completion Handler code thats executed after registrationButtonAnimation is ran
            }
            
        case 2:
            
            // Checks if firstName & lastName textfields are left blank and runs code inside of else block if they are
            guard !self.firstNameField.text!.isEmpty && !self.lastNameField.text!.isEmpty else {
                print("Please enter your name")
                sender.tag = 1
                
                self.showAlert(message: "Please enter your name.")
                
                return
            }
            
            
            // Checks to see if the desired username has been registered already
            FriendSystem.system.userRef.queryOrdered(byChild: "username").queryEqual(toValue: self.usernameField.text!).observeSingleEvent(of: .value , with: { snapshot in
                 
                // Conditional statement "if" clause that executes if the desired username is available for use
                if !snapshot.exists() {
                    // Code thats executed if username field is left blank
                    if self.usernameField.text == nil {
                        sender.tag = 1
                        self.showAlert(message: "Please enter a username.")
                        return
                    }
                    
                    // Code thats ran if desired username is less than four characters
                    else if self.usernameField.text!.count < 4 {
                        sender.tag = 1
                        
                        self.showAlert(message: "Username must contain more than four charatcers.")
                        
                        return
                    }
                        
                    // Code thats ran if desired username contains spaces
                    else if self.usernameField.text!.contains(" ") == true {
                        sender.tag = 1
                        self.showAlert(message: "Please enter a username that doesn't contain any spaces.")
                        
                        return
                    }
      
                    // What happens if username is available for use
                    else {
                        self.view.frame.origin.y = 0
                        
                        let alert = UIAlertController(title: "Almost Done!", message: "Your name is how other users will determine who you are. Once you've sumbitted your name you can't change it so make sure it's correct!", preferredStyle: .alert)
                        
                        // Code that executes if user confirms their name and username
                        let alertAction = UIAlertAction(title: "Create Account", style: .default) { (action) in
                            
                            self.showSpinner(onView: self.view)
                            
                            Auth.auth().createUser(withEmail: self.signUpEmail, password: self.signUpPassword) { (result, error) in
                                
//                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                
                                if error != nil {
                                    self.removeSpinner()
                                    self.showAlert(message: error!.localizedDescription)
                                    sender.tag = 1
                                }
                                
                                else {
                                    // Writes users data to Firebase DB
                                    FriendSystem.system.currentUserRef.setValue(["email": self.signUpEmail, "password": self.signUpPassword, "uid": Auth.auth().currentUser?.uid, "username": self.usernameField.text!, "firstName": self.firstNameField.text!, "lastName": self.lastNameField.text!])
                                    
                                    Auth.auth().signIn(withEmail: self.signUpEmail, password: self.signUpPassword) { (result, error) in
                                        if error != nil {
                                            self.showAlert(message: error!.localizedDescription)

                                        }
                                        
                                        else {
                                            // Code execute if user is succesfully signed in
                                            self.removeSpinner()
                                            print("User \(Auth.auth().currentUser!.uid) has been successfully created and signed in!")
                                            
                                            DispatchQueue.main.async {
                                                self.navigationController?.popToRootViewController(animated: false)
                                            }
                                            
                                            let token = Messaging.messaging().fcmToken
                                            
                                            if let fcmToken = token {
                                               
                                                self.ref = Database.database().reference()
                                            self.ref?.child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(["fcmToken": "\(fcmToken)"])

                                            }
                                            
//                                            appDelegate.registerForPushNotifications(application: UIApplication.shared)

                                            
                                            
                                        }
                                    }
                                }
                            }
                        }
                        
                        let noAction = UIAlertAction(title: "Go Back", style: .destructive) { (action) in
                            sender.tag = 1
                            self.view.frame.origin.y = 0
                        }
                        
                        alert.addAction(noAction)
                        alert.addAction(alertAction)
                        
                        self.present(alert, animated: true, completion: nil)
                        
                        }
                    }
                
                // Conditional statement "else" clause that executes if the desired username isn't available for use
                else {
        
                    print("That username isn't avaiable, please chooser another!")
                    sender.tag = 1
                    self.showAlert(message: "That username isn't available, please choose another.")
                    
                    return
                    }
                })
             

        default:
            print("Ok")
        }
        
    }
    
    @objc func hideAndShowText(_ sender:UIButton) {
        
        DispatchQueue.main.async {
            
            if self.passwordField.isSecureTextEntry == false {
                self.passwordField.isSecureTextEntry = true
                self.confirmPasswordField.isSecureTextEntry = true
            } else {
                self.passwordField.isSecureTextEntry = false
                self.confirmPasswordField.isSecureTextEntry = false
            }
        }
    }
}


extension UIViewController {
    
    @objc func hideKeyboard() {
        view.endEditing(true)
        view.frame.origin.y = 0
        
    }
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
       
    }
    
    @objc func animateButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2,
        animations: {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        },
        completion: { _ in
            UIView.animate(withDuration: 0.2) {
                sender.transform = CGAffineTransform.identity
                
                
            }
        })
    }
}

