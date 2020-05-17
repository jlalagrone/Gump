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
    
    // Limits messageField to 75 characters maximum
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textView.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)

        // make sure the result is under 16 characters
        return updatedText.count <= 100
    }
    
    
    @objc func chooseFriends(_ sender:UIButton) {
        
        selectedUsersID = [String]()
        
        let selectController = SelectController()
        
        if consoleField.text == "" || gameField.text == "" {
            
            let alert = UIAlertController(title: "You've left a field blank.", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Go Back", style: .default)
            
            alert.addAction(alertAction)
            present(alert, animated: true)
            
        }
        else {
            
            title = ""
        FriendSystem.system.currentUserRef.child("signals").child("onlineSignal").setValue(["game": "\(self.gameField.text!)", "console": self.consoleField.text!])
            
            self.navigationController?.pushViewController(selectController, animated: true)
            selectController.layoutSelectFriendsView()
        }
        
        
    }
    
    @objc func chooseFriendToInvite(_ sender:UIButton) {
        
        toUserUsername = String()
        
        let selectController = SelectController()
        
        guard gameField.text != "" else {
            self.showAlert(message: "Please enter a game.")
            
            return
        }
        
        if messageField.text == "" {
            let confirmAlert = UIAlertController(title: "Are you sure you want to send an invite signal with a blank message?", message: "", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
                
            // Execute code that prepares to send invite signal notification to the selected friend with blank message
                FriendSystem.system.currentUserRef.child("signals").child("inviteSignal").setValue(["game": "\(self.gameField.text!)", "message": ""])
                
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
        
        // Execute code that prepares to send invite signal to selected friend with a message
            title = ""
        FriendSystem.system.currentUserRef.child("signals").child("inviteSignal").setValue(["game":"\(gameField.text!)", "message":"\(messageField.text!)"])
            
            self.navigationController?.pushViewController(selectController, animated: true)
            selectController.layoutSelectFriendView()
            
        }
    }
    
    
}
