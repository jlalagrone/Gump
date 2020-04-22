//
//  SignalControllerExt.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/19/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase

extension SignalController {
    
    @objc func chooseFriends(_ sender:UIButton) {
        
        let selectController = SelectController()
        
        if consoleField.text == "" || gameField.text == "" {
            
            let alert = UIAlertController(title: "You've left a field blank.", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Go Back", style: .default)
            
            alert.addAction(alertAction)
            present(alert, animated: true)
            
        }
        else {
            
            title = ""
            
            self.navigationController?.pushViewController(selectController, animated: true)
            selectController.layoutSelectFriendsView()
        }
        
        
    }
    
    @objc func chooseFriendToInvite(_ sender:UIButton) {
        
        let selectController = SelectController()
        
        if gameField.text == "" {
            let confirmAlert = UIAlertController(title: "Are you sure you want to send an invite signal with a blank message?", message: "", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
                
                // Execute code that prepares to send invite signal notification to the selected friend with blank message
                self.navigationController?.pushViewController(selectController, animated: true)
                selectController.layoutSelectFriendView()
                
            }
            
            let noAction = UIAlertAction(title: "No", style: .cancel)
            confirmAlert.addAction(noAction)
            confirmAlert.addAction(yesAction)
            
            title = ""
            
            present(confirmAlert, animated: true)
        }
        
        else {
        
        // Execute code that prepares to send invite signal to selected friend
            title = ""
        FriendSystem.system.userRef.child(Auth.auth().currentUser!.uid).child("signals").child("inviteSignal").setValue(["game":"\(gameField.text!)", "message":"\(messageField.text!)"])
            
            self.navigationController?.pushViewController(selectController, animated: true)
            selectController.layoutSelectFriendView()
            
        }
    }
    
    
}
