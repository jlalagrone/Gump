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

class SelectController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var toUserToken = String()
    
    var friendsTableView:UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    var sendOnlineSignalButton = DefaultButton(backgroundColor: signalBlueColor, borderColor: UIColor.clear.cgColor, title: "Send Signal")
    
    var sendInviteSignalButton:DefaultButton = {
        var button = DefaultButton(backgroundColor: signalBlueColor, borderColor: UIColor.clear.cgColor, title: "")
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()

    
    func layoutFriendsTableView() {
        
        view.backgroundColor = .white
        view.addSubview(friendsTableView)
        
        friendsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        friendsTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        friendsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        friendsTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7).isActive = true
    
    }
    
    func layoutSelectFriendView() {
        
        title = "Select Friend"
        
        layoutFriendsTableView()

        view.addSubview(sendInviteSignalButton)
        
        sendInviteSignalButton.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        sendInviteSignalButton.heightAnchor.constraint(equalToConstant: view.frame.height / 7.5).isActive = true
        sendInviteSignalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendInviteSignalButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        sendInviteSignalButton.isHidden = true
        sendInviteSignalButton.layer.cornerRadius = 2.5
        sendInviteSignalButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height / 32.5)
        
    }
    
    func layoutSelectFriendsView() {
    
        title = "Select Friends"
        
        layoutFriendsTableView()
        
        view.addSubview(sendOnlineSignalButton)
        
        sendOnlineSignalButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        sendOnlineSignalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendOnlineSignalButton.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        sendOnlineSignalButton.heightAnchor.constraint(equalToConstant: view.frame.height / 7.5).isActive = true
        sendOnlineSignalButton.layer.cornerRadius = 2.5
        sendOnlineSignalButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height / 32.5)
        sendOnlineSignalButton.setTitleColor(.white, for: .normal)

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 12
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = FriendSystem.system.friendsList.count
        return count
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // Code executes when user has selected a friend to send an invite signal to a friend
        
        let cell = tableView.cellForRow(at: indexPath) as! SelectCell

        if title == "Select Friend" {
            
            sendInviteSignalButton.isHidden = false
            
            let username = FriendSystem.system.friendsList[indexPath.row].username
            
            toUserUsername = username
            if let token = FriendSystem.system.friendsList[indexPath.row].notificationToken {
                toUserToken = token
            }

            friendsTableView.reloadData()
            
            sendInviteSignalButton.setTitle("Send to \(username)", for: .normal)
            sendInviteSignalButton.titleLabel!.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height / 35)
            
            print("Sending to token: \(toUserToken)")
        
        }
        else {
    
            if let token = FriendSystem.system.friendsList[indexPath.row].notificationToken {
                if !selectedUsersID.contains(token) {
                    selectedUsersID.append(token)
                    cell.chosenView.isHidden = false
                }
                else {
                    selectedUsersID = selectedUsersID.filter { $0 != token }
                    cell.chosenView.isHidden = true
                }

            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        friendsTableView.register(SelectCell.self, forCellReuseIdentifier: "cellID")
        
        // Code that executes when either send button is tapped
        sendInviteSignalButton.addTarget(self, action: #selector(sendInvite(_:)), for: .touchDown)
        
        if title == "Select Friend" {
            friendsTableView.allowsMultipleSelectionDuringEditing = false
            
        } else {
            friendsTableView.allowsMultipleSelectionDuringEditing = true
            
            // Code that executes when either send button is tapped
            sendOnlineSignalButton.addTarget(self, action: #selector(sendInvites(_:)), for: .touchDown)
        }

        
        FriendSystem.system.addFriendObserver {
            self.friendsTableView.reloadData()
        }
        
    }

}


extension SelectController {
    
    
    @objc func sendInvites(_ sender:UIButton) {
        
        guard !selectedUsersID.isEmpty else {
            
            self.showAlert(message: "Please select at least one friend to send your signal too.")
            
            return
        }
        
        let sentVC = UserCreatedController()
        sentVC.modalPresentationStyle = .fullScreen
        sentVC.mainLabel.text = "Online signal(s) have been sent!"
        print("Selected IDs: \(selectedUsersID)")
        
        FriendSystem.system.getCurrentGumpUser { (user) in
            FriendSystem.system.currentUserRef.child("signals").child("onlineSignal").updateChildValues(["deviceTokens":selectedUsersID, "from": user.username])
        }
        
        self.present(sentVC, animated: true, completion: nil)
        
    }
    
    
    @objc func sendInvite(_ sender:UITapGestureRecognizer) {
        
        
        let sentVC = UserCreatedController()
        sentVC.modalPresentationStyle = .fullScreen
        sentVC.mainLabel.text = "Invite signal has been sent!"
        
        FriendSystem.system.getCurrentGumpUser { (user) in
            FriendSystem.system.currentUserRef.child("signals").child("inviteSignal").updateChildValues(["deviceToken":self.toUserToken, "from": user.username])
            
//            if let token = user.notificationToken {
//                print("Sending to token: \(token)")
//            } else {
//                print("User hasnt registered for notifications")
//            }
        }
        
        self.present(sentVC, animated: true, completion: nil)
        
    }
    
}
