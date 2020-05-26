//
//  FriendsController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/16/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class FriendsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
     

    var friendsTableView:UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        
        return tableView
    }()

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendSystem.system.friendsList.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! FriendCell
        let id = FriendSystem.system.friendsList[indexPath.row].uid
        
        cell.selectionStyle = .none
        cell.usernameLabel.text = FriendSystem.system.friendsList[indexPath.row].fullName
        
        // Logic that determines if online label is shown or not
        FriendSystem.system.userRef.child(id).observeSingleEvent(of: .value) { (snapshot) in
            let userDict = snapshot.value as! [String:AnyObject]
            let username = userDict["username"] as! String
            
        }
        
        return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = FriendSystem.system.friendsList[indexPath.row].uid
        print(id)
        
        if FriendSystem.system.friendsList[indexPath.row].uid != nil {
            print("Fetched user: \(FriendSystem.system.friendsList[indexPath.row].uid)")
        } else {
            print("Cant get fetched ID")
        }
        
        let viewProfileVC = ViewProfileController()
        viewProfileVC.profileID = id
        
        FriendSystem.system.getUser(id) { (user) in
            viewProfileVC.usernameLabel.text = user.username
            viewProfileVC.nameLabel.text = user.fullName
            
            let consoles = Array(user.gametags!.keys)
            viewProfileVC.consoleLabel.text = consoles[0]
            
            let promoText = user.promo
            
            if promoText == "no promo" {
                viewProfileVC.promoLabel.text = "This user has yet to create their promo message."
            } else {

                viewProfileVC.promoLabel.text = promoText
            }
            
        }
        
        
        self.navigationController?.pushViewController(viewProfileVC, animated: true)
        
    }
    
    
    func layoutView() {
        view.addSubview(friendsTableView)
        
        friendsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 25).isActive = true
        friendsTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        friendsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.frame.height / -23.5).isActive = true
        friendsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        friendsTableView.layer.cornerRadius = 15
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        view.backgroundColor = UIColor(red: 255.0/255.0, green: 125.0/255.0, blue: 206.0/255.0, alpha: 1)
        title = "Friends"
        
        
        print("NUMBER OF FRIENDS: \(FriendSystem.system.friendsList.count)")
        
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FriendSystem.system.addFriendObserver {
             print("Friends Count: \(FriendSystem.system.friendsList.count)!")
             self.friendsTableView.reloadData()
         }
        
        
        
        layoutView()
        
        
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        friendsTableView.register(FriendCell.self, forCellReuseIdentifier: "cellID")
   
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        FriendSystem.system.removeFriendObserver()
        print("View begone!")
    }
  

}
