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
    
    // Method that creates a FirebaseAuth account with user's email & password
    @objc func registerAccount() {
        ref = Database.database().reference()
        
        guard passwordField.text! == confirmPasswordField.text else {
            print("Passwords don't match")
            
            return
        }
        
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (result, error) in
            
            if error != nil {
                let alert = UIAlertController(title: "There's an issue!", message: error.debugDescription, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Continue", style: .default)
                self.present(alert, animated: false, completion: nil)
                
            }
            else {
                
                self.ref?.child("Users").child(Auth.auth().currentUser!.uid).setValue(["email": self.emailField.text!, "password": self.passwordField.text!, "uid": Auth.auth().currentUser?.uid])
                
            }
        }
    }
    
    
    
}
