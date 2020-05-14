//
//  ViewProfileExt.swift
//  Gump
//
//  Created by Jordan LaGrone on 5/14/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase

extension ViewProfileController {
    
    //Code that executes once sendFriendRequestButton is tapped
    @objc func sendFriendRequestAction(_ sender:UIButton) {
        
        FriendSystem.system.userRef.child(profileID).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as! [String:AnyObject]
            if let requests = value["requests"] as? [String:Bool] {
                let requestIDs = requests.keys
                
                if requestIDs.contains(FriendSystem.system.currentUserID) {
                    print("Request has already been sent!")
                    let alert = UIAlertController(title: "A friend request has already been sent to this user!", message: nil, preferredStyle: .alert)
                    let continueAction = UIAlertAction(title: "Continue", style: .default)
                    
                    alert.addAction(continueAction)
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }
            
            FriendSystem.system.sendRequestToUser(self.profileID)
            let alert = UIAlertController(title: "Friend request sent!", message: nil, preferredStyle: .alert)
            let continueAction = UIAlertAction(title: "Continue", style: .default)
           
            alert.addAction(continueAction)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    
}
