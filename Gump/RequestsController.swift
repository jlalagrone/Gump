//
//  RequestsController.swift
//  Gump
//
//  Created by Jordan LaGrone on 5/4/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

class RequestsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var mainLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You don't have any friend requests at the moment!"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-BoldItalic", size: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        
        return label
    }()

    var requestTable:UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.frame.height / 10)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendSystem.system.requestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! RequestCell
        
        let id = FriendSystem.system.requestList[indexPath.row].uid

        cell.usernameLabel.text = FriendSystem.system.requestList[indexPath.row].username
        cell.fullNameLabel.text = FriendSystem.system.requestList[indexPath.row].fullName
               
        // Code that executes once user accepts friend request
        cell.setAcceptFunction {
            print("Accepted request from \(id)")
            FriendSystem.system.acceptFriendRequest(id)

            self.requestTable.reloadData()
            
        }
        
        // Code that executes once user declines friend request
        cell.setDeclineFunction {
            print("Request declined.")
            FriendSystem.system.declineFriendRequest(id)

            self.requestTable.reloadData()
        }
        
        return cell
    }
    
    func layoutView() {
        
        view.backgroundColor = lightPinkColor
        view.addSubview(requestTable)
        view.addSubview(mainLabel)
        
        requestTable.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        requestTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        requestTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        
        mainLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height / -7.5).isActive = true
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainLabel.widthAnchor.constraint(equalToConstant: view.frame.width / 1.25).isActive = true
        
        
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutView()
        
        requestTable.reloadData()
        
        requestTable.delegate = self
        requestTable.dataSource = self
        requestTable.register(RequestCell.self, forCellReuseIdentifier: "cellID")
        
        FriendSystem.system.currentUserRef.observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as! [String:AnyObject]
//            let email = value["email"] as! String
            if let requests = value["requests"] as? [String:Bool] {
                
                
                // Code executed if user has pending friend requests
                self.requestTable.isHidden = false
                self.mainLabel.isHidden = true
                print("You have \(requests.keys.count) friend request(s) pending.")
            }
            else {
                // Code executed if user has no friend requests pending
                self.requestTable.isHidden = true
                self.mainLabel.isHidden = false
                print("No requests pending.")
                return
            }
            
        }
        
        FriendSystem.system.addRequestObserver {
            
            self.requestTable.reloadData()

            if FriendSystem.system.requestList.count == 0 {
                print("No requests at the moment")
                self.requestTable.isHidden = true
                self.mainLabel.isHidden = false
            }
            else if FriendSystem.system.requestList.count != 0 {
                self.requestTable.isHidden = false
                self.mainLabel.isHidden = true
                
            }

        }
    }
    
}
