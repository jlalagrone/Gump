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
            let email = snapshot.childSnapshot(forPath: "email").value as! String
            let username = snapshot.childSnapshot(forPath: "username").value as! String
            let id = snapshot.key
            
            // Completion handler (closure) gets the currentUser passed to it
            completion(GumpUser(email: email, uid: id, username: username))
        }
    }
    
    func getUser(_ userID:String, completion: @escaping (GumpUser) -> Void) {
        userRef.child(userID).observeSingleEvent(of: .value) { (snapshot) in
            let email = snapshot.childSnapshot(forPath: "email").value as! String
            let username = snapshot.childSnapshot(forPath: "username").value as! String
            let id = snapshot.key
            
            // Completion handler (closure) gets the specified user passed to it
            completion(GumpUser(email: email, uid: id, username: username))
        }
    }
    
    
    
    // Code executes every time a new user is created
    func addUserObserver(_ update: @escaping () -> Void) {
        FriendSystem.system.userRef.observe(DataEventType.value, with: { (snapshot) in
            self.userList.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let email = child.childSnapshot(forPath: "email").value as! String
                let username = child.childSnapshot(forPath: "username").value as! String
                if email != Auth.auth().currentUser?.email! {
                    self.userList.append(GumpUser(email: email, uid: child.key, username: username))
                }
            }
            update()
        })
    }
    
}
