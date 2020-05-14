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
        layer.borderWidth = 3
        layer.borderColor = borderColor
        layer.cornerRadius = 15
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Animation Code
    func registrationButtonAnimation(text:String?,labels:[UILabel]?,viewsToHide: [UIView],viewsToShow: [UIView], completion:() -> ()) {
        
        UIView.animate(withDuration: 0.05, animations: {
            for label in labels! {
                label.alpha = 0
            }
        }) { (bool) in
            
            UIView.animate(withDuration: 1) {
                for label in labels! {
                    label.alpha = 1
                }
                labels![0].text = text
            }
        }
 
        UIView.animate(withDuration: 0.05, animations: {
            for view in viewsToHide {
            view.alpha = 0
            
            }
        }) { (bool) in
            UIView.animate(withDuration: 1) {
                    for view in viewsToShow {
                    view.alpha = 1
                }
            }
        }
    }
    
}


extension RegistrationController {
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
            
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
        
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
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
            
            self.usernameField.isHidden = true
            self.firstNameField.isHidden = true
            self.lastNameField.isHidden = true
            
            self.consoleField.isHidden = true
            self.tagField.isHidden = true
            
            // Code if password fields aren't identical
            guard passwordField.text! == confirmPasswordField.text else {
                 print("Passwords don't match")
                let alert = UIAlertController(title: "Uh oh!", message: "Your passwords don't match.", preferredStyle: .alert)
                
                let alertAction = UIAlertAction(title: "Continue", style: .default)
                alert.addAction(alertAction)
                present(alert, animated: true, completion: {
                    sender.tag = 0
                })
                
                 return
             }

            //Displays loading spinner
            self.showSpinner(onView: self.view)
            
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (result, error) in
                
                
                
                // Displays error if there is trouble creating the account
                if error != nil {
                    self.removeSpinner()
                    let alert = UIAlertController(title: "There's an issue!", message: error!.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Continue", style: .default))
                    self.present(alert, animated: false, completion: {
                        sender.tag = 0

                    })
                    
                }
                else {
                    
                    // Saves newly created user to FirebaseDatabase
                    
                    self.ref?.child("Users").child(Auth.auth().currentUser!.uid).setValue(["email": self.emailField.text!, "password": self.passwordField.text!, "uid": Auth.auth().currentUser?.uid, "username": "n/a"])
                    print("Account created!")
                    
                    Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!) { (result, error) in
                        
                        // Displays error if newly created user can't be signed in
                        if error != nil {
                            let alert = UIAlertController(title: "Couldn't sign in", message: error!.localizedDescription, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Continue", style: .default))
                        
                            self.present(alert, animated: false, completion: nil)
                        }
                        else {

                            // Code thats ran if user is succesfully created and signed in
                            self.removeSpinner()
                            print(Auth.auth().currentUser!.uid)
                            
                            // Animates view on button tap
                            self.usernameField.isHidden = false
                            self.firstNameField.isHidden = false
                            self.lastNameField.isHidden = false
                            
                            sender.registrationButtonAnimation(text:"Please enter your name and desired username",labels:[self.mainLabel],viewsToHide: [self.emailField,self.passwordField,self.confirmPasswordField], viewsToShow: [self.usernameField,self.firstNameField,self.lastNameField])   {
                                

                                print("Loading complete!")
                            }
                            
                            self.navigationItem.setHidesBackButton(true, animated: false)
                        }
                    }
                }
            }
        case 2:
            

            self.emailField.isHidden = true
            self.emailField.removeFromSuperview()
            self.passwordField.isHidden = true
            self.passwordField.removeFromSuperview()
            self.confirmPasswordField.isHidden = true
            self.confirmPasswordField.removeFromSuperview()
            
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
            
            guard self.passwordField.text! == self.confirmPasswordField.text! else {
                
                let alert = UIAlertController(title: "Uh oh!", message: "Your passwords don't match.", preferredStyle: .alert)
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
                        alert.addAction(UIAlertAction(title: "Continue", style: .default))
                        self.present(alert, animated: true, completion: nil)
                        
                        return
                    }
                    
                    else if self.usernameField.text!.contains(" ") == true {
                        
                        // Code thats ran if desired username contains spaces
                        sender.tag = 1
                        let alert = UIAlertController(title: "Uh oh!", message: "Please choose a username that does not contain any spaces.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Continue", style: .default))
                        self.present(alert, animated: true, completion: nil)
                        
                        return
                    }
      
                    else {
                    
                        // What happens if username is avialable for use
                        let alert = UIAlertController(title: "Almost Done!", message: "Your name is how other users will determine who you are. Once you've sumbitted your name you can't change it so make sure it's correct!", preferredStyle: .alert)
                        
                        // Code that executes if user confirms their name and username
                        let alertAction = UIAlertAction(title: "Proceed", style: .default) { (action) in
                            
                            print("Hey \(self.firstNameField.text!) \(self.lastNameField.text!), your username is \(self.usernameField.text!)")
                            

                            usersRef.child(Auth.auth().currentUser!.uid).updateChildValues(["username": self.usernameField.text!, "firstName": self.firstNameField.text!, "lastName": self.lastNameField.text!])
                            
                            // Animates view on button tap
                            self.consoleField.isHidden = false
                            self.tagField.isHidden = false
                            self.view.frame.origin.y = 0
                            
                            sender.registrationButtonAnimation(text: "Enter your primary gaming console and game tag", labels: [self.mainLabel,self.secondaryLabel], viewsToHide: [self.usernameField,self.firstNameField,self.lastNameField], viewsToShow: [self.consoleField,self.tagField]) {
                            
                            
                            }
                            
                            self.mainLabel.text = "Enter your primary gaming console and game tag"
                        }
                        alert.addAction(UIAlertAction(title: "No", style: .destructive))
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
 
//
        case 3:
            
            self.usernameField.isHidden = true
            self.firstNameField.isHidden = true
            self.lastNameField.isHidden = true
            
            
            self.consoleField.isHidden = false
            self.tagField.isHidden = false
            
           
            print("Y axis: \(self.view.frame.origin.y)")
            
            finishedVC.modalPresentationStyle = .fullScreen
            
            guard consoleField.text! != "" || tagField.text! != "" else {
                print("You left a field blank!")
                sender.tag = 2
                
                let alert = UIAlertController(title: "Uh oh!", message: "Please provide your primary gaming console and gametag.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Continue", style: .default)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            
            // Code executed once registration process has been complete
  
            ref?.child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(["gametags": [consoleField.text!: tagField.text!], "promo": "no promo"])
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

