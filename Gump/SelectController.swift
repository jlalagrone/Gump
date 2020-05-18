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
var toUserToken = String()
var toUserUsername = String()
var selectedUsersID = [String]()

class SelectController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var friendsTableView:UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    var sendOnlineSignalButton = DefaultButton(backgroundColor: signalBlueColor, borderColor: UIColor.clear.cgColor, title: "Send Signal")
    
    var sendInviteSignalBackgroundView:UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = signalBlueColor
        
        return view
    }()
    
    var sendInviteSignalLabel = DefaultLabel(textColor: .white)
    var sendInviteSignalButton:DefaultButton = {
        var button = DefaultButton(backgroundColor: UIColor.clear, borderColor: UIColor.clear.cgColor, title: "")
        button.setImage(UIImage(named: "sendIcon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
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

        view.addSubview(sendInviteSignalBackgroundView)
        view.addSubview(sendInviteSignalLabel)
        view.addSubview(sendInviteSignalButton)
        
        sendInviteSignalBackgroundView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        sendInviteSignalBackgroundView.heightAnchor.constraint(equalToConstant: view.frame.height / 8.5).isActive = true
        sendInviteSignalBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendInviteSignalBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        sendInviteSignalBackgroundView.isHidden = true
        
        sendInviteSignalLabel.leftAnchor.constraint(equalTo: sendInviteSignalBackgroundView.leftAnchor, constant: 7.5).isActive = true
        sendInviteSignalLabel.centerYAnchor.constraint(equalTo: sendInviteSignalBackgroundView.centerYAnchor, constant: -2.5).isActive = true
        sendInviteSignalLabel.isHidden = true
        
        sendInviteSignalButton.rightAnchor.constraint(equalTo: sendInviteSignalBackgroundView.rightAnchor, constant: -15).isActive = true
        sendInviteSignalButton.centerYAnchor.constraint(equalTo: sendInviteSignalBackgroundView.centerYAnchor).isActive = true
        sendInviteSignalButton.heightAnchor.constraint(equalTo: sendInviteSignalBackgroundView.heightAnchor, multiplier: 0.8).isActive = true
        sendInviteSignalButton.widthAnchor.constraint(equalTo: sendInviteSignalBackgroundView.heightAnchor, multiplier: 0.8).isActive = true
        sendInviteSignalButton.isHidden = true
        
    }
    
    func layoutSelectFriendsView() {
    
        title = "Select Friends"
        
        layoutFriendsTableView()
        
        view.addSubview(sendOnlineSignalButton)
        
        sendOnlineSignalButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.frame.height / -10).isActive = true
        sendOnlineSignalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendOnlineSignalButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        sendOnlineSignalButton.heightAnchor.constraint(equalToConstant: view.frame.height / 14.5).isActive = true
        
        sendOnlineSignalButton.layer.cornerRadius = 15
        sendOnlineSignalButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: 18)
        sendOnlineSignalButton.setTitleColor(.white, for: .normal)

        
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
            
            sendInviteSignalBackgroundView.isHidden = false
            sendInviteSignalButton.isHidden = false
            sendInviteSignalLabel.isHidden = false
            
            let username = FriendSystem.system.friendsList[indexPath.row].username
            
            toUserUsername = username
            toUserToken = FriendSystem.system.friendsList[indexPath.row].notificationToken!

            friendsTableView.reloadData()
            
            sendInviteSignalLabel.text = "Tap to invite \(username)"
            sendInviteSignalLabel.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height / 35)
            
            print("Value: \(toUserUsername)")

        
        }
        else {            
    
            let token = FriendSystem.system.friendsList[indexPath.row].notificationToken
            
            if !selectedUsersID.contains(token!) {
                selectedUsersID.append(token!)
                cell.chosenView.isHidden = false
            }
            else {
                selectedUsersID = selectedUsersID.filter { $0 != token }
                cell.chosenView.isHidden = true
            }
    
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Code that executes when either send button is tapped
        sendInviteSignalButton.addTarget(self, action: #selector(sendInvite(_:)), for: .touchDown)
        
        if title == "Select Friend" {
            friendsTableView.allowsMultipleSelectionDuringEditing = false
            

            
        } else {
            friendsTableView.allowsMultipleSelectionDuringEditing = true
            
            // Code that executes when either send button is tapped
            sendOnlineSignalButton.addTarget(self, action: #selector(sendInvites(_:)), for: .touchDown)
        }

        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        friendsTableView.register(SelectCell.self, forCellReuseIdentifier: "cellID")
        
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
        
        FriendSystem.system.getCurrentUser { (user) in
            FriendSystem.system.currentUserRef.child("signals").child("onlineSignal").updateChildValues(["deviceTokens":selectedUsersID, "from": user.username])
        }
        
        self.present(sentVC, animated: true, completion: nil)
        
    }
    
    
    @objc func sendInvite(_ sender:UITapGestureRecognizer) {
        
        print("Sent invite to: \(toUserToken)")
        let sentVC = UserCreatedController()
        sentVC.modalPresentationStyle = .fullScreen
        sentVC.mainLabel.text = "Invite signal has been sent!"
        
        FriendSystem.system.getCurrentUser { (user) in
            FriendSystem.system.currentUserRef.child("signals").child("inviteSignal").updateChildValues(["deviceToken":toUserToken, "from": user.username])
            
            if let token = user.notificationToken {
                print("Sending to token: \(token)")
            } else {
                print("User hasnt registered for notifications")
            }
        }
        
        self.present(sentVC, animated: true, completion: nil)
        
    }
    
}
