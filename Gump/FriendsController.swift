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

class FriendsController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height / 4)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FriendSystem.system.friendsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FriendsCell
        
        cell.usernameLabel.text = FriendSystem.system.friendsList[indexPath.row].username
        cell.nameLabel.text = FriendSystem.system.friendsList[indexPath.row].fullName
        if let gamingDict = FriendSystem.system.friendsList[indexPath.row].gamertags {
            for (console,tag) in gamingDict {
                cell.gamertagLabel.text = tag
                cell.consoleLabel.text = console
                
            }
        }
        
        return cell
    }
    
     
    var friendsCollectionView:UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        layout.scrollDirection = .vertical

        collectionView.register(FriendsCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

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
            
            let consoles = Array(user.gamertags!.keys)
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
        view.addSubview(friendsCollectionView)
        
        friendsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 25).isActive = true
        friendsCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        friendsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.frame.height / -23.5).isActive = true
        friendsCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        view.backgroundColor = UIColor(red: 255.0/255.0, green: 125.0/255.0, blue: 206.0/255.0, alpha: 1)
        title = "Friends"
        
        
        print("NUMBER OF FRIENDS: \(FriendSystem.system.friendsList.count)")
        
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsCollectionView.backgroundColor = .white
        friendsCollectionView.delegate = self
        friendsCollectionView.dataSource = self
        
        FriendSystem.system.addFriendObserver {
             print("Friends Count: \(FriendSystem.system.friendsList.count)!")
             self.friendsCollectionView.reloadData()
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
