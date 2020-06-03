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
    
    @objc func viewTagsButtonAction(_ sender:UIButton) {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        
        alert.addAction(closeAction)
        
        FriendSystem.system.getUser(profileID) { (user) in
            let gamertagDict = user.gamertags
//            let gametags = Array(gametagDict.values)
            
            print("Gametags -> \(gamertagDict)")
            
            
            alert.title = "\(user.username)'s gametags"
            alert.message = "\(gamertagDict)"
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @objc func viewGamesButtonAction(_ sender:UIButton) {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .default, handler: nil)
          
        alert.addAction(closeAction)
          
        FriendSystem.system.getUser(profileID) { (user) in
            
            if let gamesDict = user.games {
                let games = Array(gamesDict.values)
                
                var gameText = String()
                
                for game in games {
                    gameText.append("\(game), ")
                }
                
                print("Games -> \(games)")

                alert.title = "\(user.username)'s games"
                alert.message = "\(gameText)"
                    
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            alert.title = "The user's game library is currently empty."
            self.present(alert, animated: true, completion: nil)

            
        }
        
                 
    }
    
    
    
}
