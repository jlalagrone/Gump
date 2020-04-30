//
//  SearchController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/28/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    var searchActive:Bool = false
    var filteredUsers = [GumpUser]()
    
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
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        self.filteredUsers = []
        
        let queryRef = FriendSystem.system.userRef.queryOrdered(byChild: "username").queryStarting(atValue: searchText)
        
        queryRef.observeSingleEvent(of: .value) { (snapshot) in
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                let uid = userSnap.key
                let userDict = userSnap.value as! [String:AnyObject]
                let email = userDict["email"] as! String
                let username = userDict["username"] as! String
                let firstName = userDict["firstName"] as! String
                let lastName = userDict["lastName"] as! String
                let fullName = "\(firstName) \(lastName)"
                
                self.filteredUsers.append(GumpUser(email: email, uid: uid, username: username, fullName: fullName))
            }
            
            if self.filteredUsers.count == 0 {
                self.searchActive = false
            } else {
                self.searchActive = true
            }
            self.searchTable.reloadData()
        }
        
        
    }
    
    
    var searchField = DefaultTextField(color: .white, borderColor: UIColor(white: 0.9, alpha: 1).cgColor, placeholderText: "Enter Username", placeholderLength: 14)
    
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
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return view.frame.height / 8
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! SearchCell
        
        if (searchActive) {
            cell.usernameLabel.text = filteredUsers[indexPath.row].username
            cell.fullNameLabel.text = filteredUsers[indexPath.row].fullName
        } else {
            cell.usernameLabel.text = "N/A"
            cell.fullNameLabel.text = "N/A"
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
