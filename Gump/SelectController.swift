//
//  SelectController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/19/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase

var toUserID = String()
var toUserUsername = String()
var selectedUsersID = [String]()
var selectedUsersUsernames = [String]()

class SelectController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var friendsTableView:UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    var sendSignalButton = DefaultButton(backgroundColor: darkPinkColor, borderColor: UIColor.clear.cgColor, title: "Send Signal")
    
    var sendOnlineSignalBackgroundView:UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = signalBlueColor
        
        return view
    }()
    
    var sendOnlineSignalLabel = DefaultLabel(textColor: .white)
    var sendOnlineSignalIcon:UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "sendIcon")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    func layoutFriendsTableView() {
        
        view.addSubview(friendsTableView)
        
        friendsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        friendsTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        friendsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        friendsTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9).isActive = true
    
    }
    
    func layoutSelectFriendView() {
        
        title = "Select Friend"
        
        layoutFriendsTableView()

        view.addSubview(sendOnlineSignalBackgroundView)
        view.addSubview(sendOnlineSignalLabel)
        view.addSubview(sendOnlineSignalIcon)
        
        sendOnlineSignalBackgroundView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        sendOnlineSignalBackgroundView.heightAnchor.constraint(equalToConstant: view.frame.height / 8.5).isActive = true
        sendOnlineSignalBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendOnlineSignalBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        sendOnlineSignalBackgroundView.isHidden = true
        
        sendOnlineSignalLabel.leftAnchor.constraint(equalTo: sendOnlineSignalBackgroundView.leftAnchor, constant: 10).isActive = true
        sendOnlineSignalLabel.centerYAnchor.constraint(equalTo: sendOnlineSignalBackgroundView.centerYAnchor, constant: -2).isActive = true
        sendOnlineSignalLabel.isHidden = true
        
        sendOnlineSignalIcon.rightAnchor.constraint(equalTo: sendOnlineSignalBackgroundView.rightAnchor, constant: -15).isActive = true
        sendOnlineSignalIcon.centerYAnchor.constraint(equalTo: sendOnlineSignalBackgroundView.centerYAnchor).isActive = true
        sendOnlineSignalIcon.heightAnchor.constraint(equalTo: sendOnlineSignalBackgroundView.heightAnchor, multiplier: 0.6).isActive = true
        sendOnlineSignalIcon.widthAnchor.constraint(equalTo: sendOnlineSignalBackgroundView.heightAnchor, multiplier: 0.6).isActive = true
        sendOnlineSignalIcon.isHidden = true
        
    }
    
    func layoutSelectFriendsView() {
    
        title = "Select Friends"
        
        layoutFriendsTableView()
        
        view.addSubview(sendSignalButton)
        
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
    
    @objc func sendInviteSignal(_ sender:UIButton) {
        
        print("Let's get cooking")
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 14.5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendSystem.system.friendsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! SelectCell
        
        cell.usernameLabel.text = FriendSystem.system.friendsList[indexPath.row].username
        cell.selectionStyle = .none
        
        if title == "Select Friend" {
            
            if cell.usernameLabel.text == toUserUsername {
                cell.chosenView.isHidden = false
            } else {
                cell.chosenView.isHidden = true
                
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // Code executes when user has selected a friend to send an invite signal to a friend
        
        let cell = tableView.cellForRow(at: indexPath) as! SelectCell

        if title == "Select Friend" {
            
            sendOnlineSignalBackgroundView.isHidden = false
            sendOnlineSignalIcon.isHidden = false
            sendOnlineSignalLabel.isHidden = false
            
            let id = FriendSystem.system.friendsList[indexPath.row].uid
            let username = FriendSystem.system.friendsList[indexPath.row].username
            toUserUsername = username
            friendsTableView.reloadData()
            
            sendOnlineSignalLabel.text = "Tap to invite \(username)"
            sendOnlineSignalLabel.font = UIFont(name: "AvenirNext-Heavy", size: 14.5)
            
            print("Value: \(toUserUsername)")

        FriendSystem.system.userRef.child(Auth.auth().currentUser!.uid).child("signals").child("inviteSignal").updateChildValues(["to":["username":"\(username)", "id":"\(id)"]])
        
        }
        else {            
    
            let username = FriendSystem.system.friendsList[indexPath.row].username
            let id = FriendSystem.system.friendsList[indexPath.row].uid
            
            if !selectedUsersUsernames.contains(username) {
                selectedUsersUsernames.append(username)
                cell.chosenView.isHidden = false
            }
            else {
                selectedUsersUsernames = selectedUsersUsernames.filter { $0 != username }
                cell.chosenView.isHidden = true
            }
    
            print("Selecting \(selectedUsersUsernames)")
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if title == "Select Friend" {
            friendsTableView.allowsMultipleSelectionDuringEditing = false
        } else {
            friendsTableView.allowsMultipleSelectionDuringEditing = true
        }

        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        friendsTableView.register(SelectCell.self, forCellReuseIdentifier: "cellID")
        
        FriendSystem.system.addFriendObserver {
            self.friendsTableView.reloadData()
        }
        
        sendSignalButton.addTarget(self, action: #selector(sendInviteSignal(_:)), for: .touchDown)
    }
    


}
