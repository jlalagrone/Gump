//
//  SelectController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/19/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

class SelectController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var friendsTableView:UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        
        
        return tableView
    }()
    
    var sendSignalButton = DefaultButton(backgroundColor: darkPinkColor, borderColor: UIColor.clear.cgColor, title: "Send Signal")
    
    
    func layoutFriendsTableView() {
        
        view.addSubview(friendsTableView)
        view.addSubview(sendSignalButton)

        
        friendsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        friendsTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        friendsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        friendsTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9).isActive = true
        sendSignalButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.frame.height / -10).isActive = true
        sendSignalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendSignalButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        sendSignalButton.heightAnchor.constraint(equalToConstant: view.frame.height / 13).isActive = true
        
        sendSignalButton.layer.cornerRadius = 15
        sendSignalButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: 20)
        sendSignalButton.setTitleColor(.white, for: .normal)
        sendSignalButton.layer.shadowRadius = 1.5
        sendSignalButton.layer.shadowOpacity = 1.0
        sendSignalButton.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        sendSignalButton.layer.shadowColor = UIColor(white: 0, alpha: 0.75).cgColor
        sendSignalButton.titleLabel?.layer.shadowColor = UIColor(white: 0, alpha: 0.85).cgColor
        sendSignalButton.titleLabel?.layer.shadowOpacity = 1.0
        sendSignalButton.titleLabel?.layer.shadowRadius = 0.5
        sendSignalButton.titleLabel?.layer.shadowOffset = CGSize(width: 0.5, height: 1)
    }
    
    func layoutSelectFriendView() {
        
        title = "Select Friend"
        
        layoutFriendsTableView()

        
    }
    
    func layoutSelectFriendsView() {
    
        title = "Select Friends"
        
        layoutFriendsTableView()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendSystem.system.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! SelectCell
        
        cell.usernameLabel.text = FriendSystem.system.userList[indexPath.row].username
        
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        friendsTableView.register(SelectCell.self, forCellReuseIdentifier: "cellID")
        
        FriendSystem.system.addUserObserver {
            self.friendsTableView.reloadData()
        }
    }
    


}
