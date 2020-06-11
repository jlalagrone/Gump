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
    var friendsList = [GumpUser]()
    var requestList = [GumpUser]()
    var gametags = [String:String]()
    var gamertags = [String:String]()
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
    
    var currentUserRequestsRef: DatabaseReference {
        return currentUserRef.child("requests")
    }
    
    var currentUserID:String {
        let id = Auth.auth().currentUser!.uid
        return id
    }
        
    func getCurrentGumpUser(_ completion: @escaping (GumpUser) -> Void) {
        currentUserRef.observeSingleEvent(of: .value) { (snapshot) in
            let id = snapshot.key

            let email = snapshot.childSnapshot(forPath: "email").value as! String
            let username = snapshot.childSnapshot(forPath: "username").value as! String
            let promo = snapshot.childSnapshot(forPath: "promo").value as? String
            let firstName = snapshot.childSnapshot(forPath: "firstName").value as! String
            let lastName = snapshot.childSnapshot(forPath: "lastName").value as! String
            var fullName:String {
                "\(firstName) \(lastName)"
            }
            let requests = snapshot.childSnapshot(forPath: "requests").value as? [String:Bool]
            let games = snapshot.childSnapshot(forPath: "games").value as? [String:String]
            let token = snapshot.childSnapshot(forPath: "fcmToken").value as? String
            let gamertags = snapshot.childSnapshot(forPath: "gamertags").value as? [String:String]
            if let gTags = gamertags {
                self.gamertags = gTags
                
                if let token = token {
                    completion(GumpUser(email: email, uid: id, username: username, fullName: fullName, promo: promo, games: games, gamertags: gTags, requests: requests, notificationToken: token))
                    
                    return
                }
            }
            else {
                
                if let token = token {
                    completion(GumpUser(email: email, uid: id, username: username, fullName: fullName, promo: promo, games:games, gamertags:nil, requests: requests, notificationToken: token))
                    
                    return
                    }
                }
            
            completion(GumpUser(email: email, uid: id, username: username, fullName: fullName, promo: promo, games:games, gamertags:nil, requests: requests, notificationToken: nil))
            }
        }
        
    func getUser(_ userID:String, completion: @escaping (GumpUser) -> Void) {
        userRef.child(userID).observeSingleEvent(of: .value) { (snapshot) in
            let email = snapshot.childSnapshot(forPath: "email").value as! String
            let username = snapshot.childSnapshot(forPath: "username").value as! String
            let games =  snapshot.childSnapshot(forPath: "games").value as? [String:String]
            let requests = snapshot.childSnapshot(forPath: "requests").value as? [String:Bool]
            let firstName = snapshot.childSnapshot(forPath: "firstName").value as! String
            let lastName = snapshot.childSnapshot(forPath: "lastName").value as! String
            let promo = snapshot.childSnapshot(forPath: "promo").value as? String
            let token = snapshot.childSnapshot(forPath: "fcmToken").value as? String
            let fullName = "\(firstName) \(lastName)"
            let id = snapshot.key
                        
            if let gTags = snapshot.childSnapshot(forPath: "gamertags").value as? [String:String] {
                self.gamertags = gTags

                if let token = token {
                    completion(GumpUser(email: email, uid: id, username: username, fullName: fullName,promo: promo, games: games, gamertags: gTags, requests: requests, notificationToken: token))
                    
                    return
                        }
                }
                else {
                
                if let token = token {
                    // Completion handler (closure) gets the specified user passed to it
                    completion(GumpUser(email: email, uid: id, username: username, fullName: fullName, promo: promo,games: games, gamertags: nil, requests: requests, notificationToken: token))
                    
                    return
                }
                // Completion handler (closure) gets the specified user passed to it
                completion(GumpUser(email: email, uid: id, username: username, fullName: fullName, promo: promo,games: games, gamertags: nil, requests: requests, notificationToken: nil))
                
            }
        }
    }
        
    func logoutAccount() {
        
        print("About to sign out user \(FriendSystem.system.currentUserID)")
        
        try! Auth.auth().signOut()
        print("User signed out.")
        
    }
    
    func addFriendObserver(_ update: @escaping () -> Void) {
        currentUserFriendsRef.observe(DataEventType.value, with: { (snapshot) in
            self.friendsList.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let id = child.key
                self.getUser(id, completion: { (user) in
                    self.friendsList.append(user)
                    update()
                })
            }
            // If there are no children, run completion here instead
            if snapshot.childrenCount == 0 {
                update()
            }
        })
    }
    
    func removeFriendObserver() {
        currentUserRef.removeAllObservers()
    }
    
    
    // Sends friend request to the user with the specified ID
    func sendRequestToUser(_ userID: String) {
                    
        userRef.child(userID).child("requests").child(self.currentUserID).setValue(true)
            print("Request has been sent!")

    }
    
    func acceptFriendRequest(_ userID: String) {
        
        currentUserRef.child("requests").child(userID).removeValue()
        currentUserRef.child("friends").child(userID).setValue(true)
        userRef.child(userID).child("friends").child(currentUserID).setValue(true)
        userRef.child(userID).child("requests").child(currentUserID).removeValue()
    }
    
    func declineFriendRequest(_ userID: String) {
        currentUserRef.child("requests").child(userID).removeValue()
        
        
    }

    func addRequestObserver(_ update: @escaping () -> Void) {
        currentUserRequestsRef.observe(DataEventType.value, with: { (snapshot) in
            self.requestList.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let id = child.key
                self.getUser(id, completion: { (user) in
                    self.requestList.append(user)
                    
                    update()
                })
            }
            // If there are no children, run completion here instead
            if snapshot.childrenCount == 0 {
                
                update()
            }
        })
    }
    
    func removeRequestObserver() {
        currentUserRef.removeAllObservers()
    }
}
