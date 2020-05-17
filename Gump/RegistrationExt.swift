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
                    
                    UIView.animate(withDuration: 1.25) {
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
   
        let usersRef = Database.database().reference().child("Users")
        ref = Database.database().reference()

        let finishedVC = UserCreatedController()
        
        sender.tag += 1
        print("SENDER TAG: \(sender.tag)")
        
        if sender.tag > 3 { sender.tag = 0 }
        
        switch sender.tag {
        case 1:
            
//            self.usernameField.isHidden = true
//            self.firstNameField.isHidden = true
//            self.lastNameField.isHidden = true
//
//            self.consoleField.isHidden = true
//            self.tagField.isHidden = true
            
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
            //Displays loading spinner
            self.showSpinner(onView: self.view)
            
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (result, error) in
                
                // Displays error if there is trouble creating the account
                if error != nil {
                    self.removeSpinner()
                    self.showAlert(message: error!.localizedDescription)
                    sender.tag = 0
                    
                }
                else {
                    // Saves newly created user to FirebaseDatabase
                    FriendSystem.system.currentUserRef.setValue(["email": self.emailField.text!, "password": self.passwordField.text!, "uid": Auth.auth().currentUser?.uid, "username": "n/a"])
                    print("Account created!")
                    
                    Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!) { (result, error) in
                        
                        // Displays error if newly created user can't be signed in
                        if error != nil {
                            self.showAlert(message: error!.localizedDescription)
                        }
                        else {
                            // Code thats ran if user is created and succesfully signed in
                            self.removeSpinner()
                            print(Auth.auth().currentUser!.uid)
                            
                            // Animates view on button tap
//                            self.usernameField.isHidden = false
//                            self.firstNameField.isHidden = false
//                            self.lastNameField.isHidden = false
                            
                            DispatchQueue.main.async {
                                
                                sender.registrationButtonAnimation(text:"Please enter your name and desired username",label:self.mainLabel,viewsToHide: [self.emailField,self.passwordField,self.confirmPasswordField], viewsToShow: [self.usernameField,self.firstNameField,self.lastNameField])   {
                                    
                                }
                                print("Done loading! \nUser succesfully created and signed in!")

                            }
                            
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
                
                self.showAlert(message: "Please enter your first and last name.")
                
                return
            }
            
            guard self.passwordField.text! == self.confirmPasswordField.text! else {
                
                let alert = UIAlertController(title: "Uh oh!", message: "Your passwords don't match.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Continue", style: .default)
                alert.addAction(alertAction)
                present(alert, animated: true, completion: nil)
                
                return
                
            }
            
            // Checks to see if the desired username has been registered already
            FriendSystem.system.userRef.queryOrdered(byChild: "username").queryEqual(toValue: self.usernameField.text!).observeSingleEvent(of: .value , with: { snapshot in
                 
                
                // Conditional statement "if" clause that executes if the desired username is available for use
                if !snapshot.exists() {
                    // Code thats executed if username field is left blank
                    if self.usernameField.text! == "" {
                        sender.tag = 1
                        self.showAlert(message: "Please enter a username.")
                        return
                    }
                        
                    // Code thats ran if desired username contains spaces
                    else if self.usernameField.text!.contains(" ") == true {
                        sender.tag = 1
                        self.showAlert(message: "Please enter a username that doesn't contain any spaces.")
                        
                        return
                    }
      
                    else {
                        // What happens if username is avialable for use
                        let alert = UIAlertController(title: "Almost Done!", message: "Your name is how other users will determine who you are. Once you've sumbitted your name you can't change it so make sure it's correct!", preferredStyle: .alert)
                        
                        // Code that executes if user confirms their name and username
                        let alertAction = UIAlertAction(title: "Proceed", style: .default) { (action) in
                            
                            print("Hey \(self.firstNameField.text!) \(self.lastNameField.text!), your username is \(self.usernameField.text!)")
                            
                            usersRef.child(FriendSystem.system.currentUserID).updateChildValues(["username": self.usernameField.text!, "firstName": self.firstNameField.text!, "lastName": self.lastNameField.text!])
                            
                            // Animates view on button tap
//                            self.consoleField.isHidden = false
//                            self.tagField.isHidden = false
                            self.view.frame.origin.y = 0
                            

                            DispatchQueue.main.async {
                                sender.registrationButtonAnimation(text: "Enter your primary gaming console and game tag", label: self.mainLabel, viewsToHide: [self.usernameField,self.firstNameField,self.lastNameField], viewsToShow: [self.consoleField,self.tagField]) {
//                                self.consoleField.isHidden = false
//                                self.tagField.isHidden = false
                                
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
            
            print("Button on second instance")
 

        case 3:
            
//            self.usernameField.isHidden = true
//            self.firstNameField.isHidden = true
//            self.lastNameField.isHidden = true
            
            DispatchQueue.main.async {
//                self.consoleField.isHidden = false
//                self.tagField.isHidden = false
            }
            
//            self.consoleField.isHidden = false
//            self.tagField.isHidden = false
            
           
            print("Y axis: \(self.view.frame.origin.y)")
            
            finishedVC.modalPresentationStyle = .fullScreen
            
            guard consoleField.text! != "" || tagField.text! != "" else {
                print("You left a field blank!")
                sender.tag = 2
                self.showAlert(message: "Please enter a gametag for a console you currently use.")
                return
            }
            
            // Code executed once registration process has been complete
            FriendSystem.system.currentUserRef.updateChildValues(["gametags": [consoleField.text!: tagField.text!], "promo": "no promo"])
            present(finishedVC, animated: true) {
                print("Registration Complete!")
            }
            

        default:
            print("Ok")
        }
        
    }
    
    
    
}


extension UIViewController {
    
    @objc func hideKeyboard() {
        view.endEditing(true)
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

