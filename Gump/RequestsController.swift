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
        return (view.frame.height / 10.5)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendSystem.system.requestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! RequestCell
        
        cell.usernameLabel.text = FriendSystem.system.requestList[indexPath.row].username
        cell.fullNameLabel.text = FriendSystem.system.requestList[indexPath.row].fullName
        
        cell.declineButton.addTarget(self, action: #selector(denyRequest(_:)), for: .touchDown)
        
        cell.setAcceptFunction {
            
            let id = FriendSystem.system.requestList[indexPath.row].uid
            FriendSystem.system.acceptFriendRequest(id)
            
            print("Request accepted from \(id)")
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
        mainLabel.widthAnchor.constraint(equalToConstant: view.frame.height / 2).isActive = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutView()
        
        print("Requests --> \(FriendSystem.system.requestList)!")

        requestTable.delegate = self
        requestTable.dataSource = self
        requestTable.register(RequestCell.self, forCellReuseIdentifier: "cellID")
        
        FriendSystem.system.addRequestObserver {
            print("Requests Count--> \(FriendSystem.system.requestList)!")
            self.requestTable.reloadData()
            
            if FriendSystem.system.requestList.count == 0 {
                print("No requests at the moment")
                self.requestTable.isHidden = true
                self.mainLabel.isHidden = false
            }
            else if FriendSystem.system.requestList.count != 0 {
                self.requestTable.isHidden = false
                self.mainLabel.isHidden = true
                print("You have pending requests.")
            }

        }
    }
    
}
