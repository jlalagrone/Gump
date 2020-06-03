//
//  SearchController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/28/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase

var requestID = String()

class SearchController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return FriendSystem.system.userList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchedCell
        let id = FriendSystem.system.userList[indexPath.row].uid
        
        cell.usernameLabel.text = FriendSystem.system.userList[indexPath.row].username
        cell.nameLabel.text = FriendSystem.system.userList[indexPath.row].fullName
        
        cell.setRequestFunction {
            FriendSystem.system.userRef.child(id).observeSingleEvent(of: .value) { (snapshot) in
                let value = snapshot.value as! [String:AnyObject]
                
                if let friends = value["friends"] as? [String:Bool] {
                    let friendIDs = Array(friends.keys)
                    if friendIDs.contains(FriendSystem.system.currentUserID) {
                        self.showAlert(message: "This user is already your friend!")
                        return
                    }
                }
                
                if let requests = value["requests"] as? [String:Bool] {
                    let requestIDs = requests.keys
                    
                    if requestIDs.contains(FriendSystem.system.currentUserID) {
                        print("Request has already been sent!")
                        self.showAlert(message: "You already have a friend request pending for this user!")
                        return
                    }
                }
                
                FriendSystem.system.sendRequestToUser(id)
                self.showAlert(message: "Friend request sent!")

                
            }
        }
        
        cell.setProfileFunction {
            
            let viewVC = ViewProfileController()
            viewVC.profileID = id
            
            if viewVC.profileID == FriendSystem.system.currentUserID {
                viewVC.sendFriendRequestButton.isHidden = true

            }
            
            FriendSystem.system.getUser(id) { (user) in
                viewVC.usernameLabel.text = user.username
                viewVC.nameLabel.text = user.fullName
                
                if let tagDict = user.gamertags {
                    for (console,tag) in tagDict {
                        viewVC.consoleLabel.text = console
                        return
                    }
                }
                else {
                    viewVC.consoleLabel.text = "N/A"
                }
                
                if let promo = user.promo {
                    viewVC.promoLabel.text = promo
                }
                
            }
            
            self.navigationController?.pushViewController(viewVC, animated: true)
            
        }
        
        return cell
    }
    
    var searchCollectionView:UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        layout.scrollDirection = .vertical

        collectionView.register(SearchedCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    
    var searchActive:Bool = false
    
    var searchTable:UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    var searchBar:UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont(name: "AvenirNext-Medium", size: 16.5)
            textField.textColor = .black
            textField.backgroundColor = .white
        }
        
        searchBar.barTintColor = lightPinkColor
        
        return searchBar
    }()

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
  
        searchBar.endEditing(true)
        
        FriendSystem.system.userList = []

        let queryRef = FriendSystem.system.userRef.queryStarting(atValue: searchBar.text).queryOrdered(byChild: "username").queryLimited(toFirst: 10)
                
        queryRef.observeSingleEvent(of: .value) { (snapshot) in
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                let uid = userSnap.key
                let userDict = userSnap.value as! [String:AnyObject]
                let email = userDict["email"] as! String
                let gamertags = userDict["gametags"] as? [String:String]
                let requests = userDict["requests"] as? [String:Bool]
                let username = userDict["username"] as! String
                let firstName = userDict["firstName"] as! String
                let lastName = userDict["lastName"] as! String
                let fullName = "\(firstName) \(lastName)"
                let promo = userDict["promo"] as? String
                let token = userDict["fcmToken"] as? String
                let games = userDict["games"] as? [String:String]
                    
                FriendSystem.system.userList.append(GumpUser(email: email, uid: uid, username: username, fullName: fullName,promo: promo,games:games, gamertags: gamertags,requests: requests, notificationToken: token))
                
                print("Search List: \(FriendSystem.system.userList.count)")
                
                self.searchCollectionView.reloadData()
                        
            }

        }
  
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

  
    }
    

    
    func layoutView() {

        view.addSubview(searchBar)
        view.addSubview(searchCollectionView)
        
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: view.frame.height / 11).isActive = true
    
        searchCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        searchCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        searchCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height / -20).isActive = true
        
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = lightPinkColor
        title = "Search"
        layoutView()
        
        searchBar.delegate = self
        
        searchCollectionView.backgroundColor = backgroundPinkColor
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        
    }
    


}
