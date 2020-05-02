//
//  FriendSystem.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/16/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class FriendSystem {
    
    static let system = FriendSystem()
    
    var userList = [GumpUser]()
    var gametags = [String:String]()
    var gameList = [String]()
    
    let baseRef = Database.database().reference()
    
    let userRef = Database.database().reference().child("Users")
    
    // Fetches current user
    var currentUserRef:DatabaseReference {
        let id = Auth.auth().currentUser!.uid
        return userRef.child(id)
        
    }
    
    var currentUserFriendsRef:DatabaseReference {
        return currentUserRef.child("friends")
    }
    
    var currentUserID:String {
        let id = Auth.auth().currentUser!.uid
        return id
    }
    
    func getCurrentUser(_ completion: @escaping (GumpUser) -> Void) {
        currentUserRef.observeSingleEvent(of: .value) { (snapshot) in
            let id = snapshot.key
            let email = snapshot.childSnapshot(forPath: "email").value as! String
            let username = snapshot.childSnapshot(forPath: "username").value as! String
            let gametags = snapshot.childSnapshot(forPath: "gametags").value as! [String:String]
            let firstName = snapshot.childSnapshot(forPath: "firstName").value as! String
            let lastName = snapshot.childSnapshot(forPath: "lastName").value as! String
            let fullName = "\(firstName) \(lastName)"
            
            self.gametags = gametags
            
            if let games = snapshot.childSnapshot(forPath: "Games").value as? [String:String] {
                let gameTitles = Array(games.values)
            
                print(games.values)
                self.gameList = gameTitles
                
                completion(GumpUser(email: email, uid: id, username: username, fullName: fullName, gametags: gametags ,games: games))
                
            }
            else {
            // Completion handler (closure) gets the currentUser passed to it
                completion(GumpUser(email: email, uid: id, username: username, fullName: fullName, gametags: gametags ,games: nil))
            }
        }
    }
    
    func getUser(_ userID:String, completion: @escaping (GumpUser) -> Void) {
        userRef.child(userID).observeSingleEvent(of: .value) { (snapshot) in
            let email = snapshot.childSnapshot(forPath: "email").value as! String
            let username = snapshot.childSnapshot(forPath: "username").value as! String
            let gametags = snapshot.childSnapshot(forPath: "gametags").value as! [String:String]
            let firstName = snapshot.childSnapshot(forPath: "firstName").value as! String
            let lastName = snapshot.childSnapshot(forPath: "lastName").value as! String
            let fullName = "\(firstName) \(lastName)"
            let games = snapshot.childSnapshot(forPath: "Games").value as! [String:String]
            let id = snapshot.key
            
            // Completion handler (closure) gets the specified user passed to it
            completion(GumpUser(email: email, uid: id, username: username, fullName: fullName, gametags: gametags ,games: games))
        }
    }
        
    
    // Code executes every time a new user is created
    func addUserObserver(_ update: @escaping () -> Void) {
        FriendSystem.system.userRef.observe(DataEventType.value, with: { (snapshot) in
            self.userList.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let email = child.childSnapshot(forPath: "email").value as! String
                let username = child.childSnapshot(forPath: "username").value as! String
                let gametags = snapshot.childSnapshot(forPath: "gametags").value as! [String:String]
                let firstName = child.childSnapshot(forPath: "firstName").value as! String
                let lastName = child.childSnapshot(forPath: "lastName").value as! String
                let fullName = "\(firstName) \(lastName)"
                let games = child.childSnapshot(forPath: "Games").value as! [String:String]
                if email != Auth.auth().currentUser?.email! {
                    self.userList.append(GumpUser(email: email, uid: child.key, username: username, fullName: fullName, gametags: gametags ,games:games))
                }
            }
            update()
        })
    }
    
}
