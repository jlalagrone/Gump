//
//  AccountExt.swift
//  Gump
//
//  Created by Jordan LaGrone on 5/3/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase

extension AccountController {
    
    func presentSuccessAlert(title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Continue", style: .default) { (action) in
            
        }
        
        alert.addAction(doneAction)
        
        self.present(alert, animated: true) {
        
            self.tagsTable.reloadData()
        }
    }
    
    @objc func addTag(_ sender:UIButton) {
       
        let alert = UIAlertController(title: "Add a Gametag", message: "Please enter the platform in the top field and your gametag/username on the second.", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        
        alert.textFields![0].placeholder = "Example: PS4, Xbox One"
        alert.textFields![1].placeholder = "Enter Gamertag"
        
        let addTagAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
            let consoleText = alert.textFields![0]
            let gamertagText = alert.textFields![1]
            
        FriendSystem.system.currentUserRef.child("gamertags").updateChildValues([consoleText.text!:gamertagText.text!])
            
            FriendSystem.system.gamertags[consoleText.text!] = gamertagText.text!

            self.presentSuccessAlert(title: "Gametag Added!", message: "")
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(cancelAction)
        alert.addAction(addTagAction)
        
        present(alert, animated: true, completion: nil)
        
    }
}
