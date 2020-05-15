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

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
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
  
        FriendSystem.system.userList = []

        let queryRef = FriendSystem.system.userRef.queryOrdered(byChild: "username").queryStarting(atValue: searchBar.text)
                
        queryRef.observeSingleEvent(of: .value) { (snapshot) in
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                let uid = userSnap.key
                let userDict = userSnap.value as! [String:AnyObject]
                let email = userDict["email"] as! String
                let gametags = userDict["gametags"] as! [String:String]
                let requests = userDict["requests"] as? [String:Bool]
                let username = userDict["username"] as! String
                let firstName = userDict["firstName"] as! String
                let lastName = userDict["lastName"] as! String
                let fullName = "\(firstName) \(lastName)"
                let promo = userDict["promo"] as! String
                if let games = userDict["Games"] as? [String:String] {
                    
                    FriendSystem.system.userList.append(GumpUser(email: email, uid: uid, username: username, fullName: fullName,promo: promo,gametags: gametags,requests: requests ,games:games))
                    self.searchTable.reloadData()

                } else {
                    
                    FriendSystem.system.userList.append(GumpUser(email: email, uid: uid, username: username, fullName: fullName,promo: promo,gametags: gametags, requests: requests,games:nil))
                    self.searchTable.reloadData()
                }
                
                    
            }
//            self.searchTable.reloadData()

        }

  
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

  
    }
    

    
    func layoutView() {

        view.addSubview(searchBar)
        view.addSubview(searchTable)
        
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: view.frame.height / 11).isActive = true
    
        searchTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        searchTable.widthAnchor.constraint(equalToConstant: view.frame.width / 1.1).isActive = true
        searchTable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height / -20).isActive = true
        searchTable.layer.cornerRadius = 7.5
        
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.frame.height / 10.5)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return FriendSystem.system.userList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! SearchCell
        
        let id = FriendSystem.system.userList[indexPath.row].uid
        
        cell.selectionStyle = .none
        cell.usernameLabel.text = FriendSystem.system.userList[indexPath.row].username
        cell.fullNameLabel.text = FriendSystem.system.userList[indexPath.row].fullName
        
        
        cell.setFunction {
            
            let viewVC = ViewProfileController()
            viewVC.profileID = id
            self.navigationController?.pushViewController(viewVC, animated: true)
            

        }
        
        return cell
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        searchBar.delegate = self
        
        view.backgroundColor = lightPinkColor
        title = "Search"
        layoutView()
        
        searchTable.dataSource = self
        searchTable.delegate = self
        searchTable.register(SearchCell.self, forCellReuseIdentifier: "cellID")
    }
    


}
