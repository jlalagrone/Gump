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
    
    var sendOnlineSignalButton = DefaultButton(backgroundColor: darkPinkColor, borderColor: UIColor.clear.cgColor, title: "Send Signal")
    
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
        
        sendInviteSignalLabel.leftAnchor.constraint(equalTo: sendInviteSignalBackgroundView.leftAnchor, constant: 10).isActive = true
        sendInviteSignalLabel.centerYAnchor.constraint(equalTo: sendInviteSignalBackgroundView.centerYAnchor, constant: -2).isActive = true
        sendInviteSignalLabel.isHidden = true
        
        sendInviteSignalButton.rightAnchor.constraint(equalTo: sendInviteSignalBackgroundView.rightAnchor, constant: -15).isActive = true
        sendInviteSignalButton.centerYAnchor.constraint(equalTo: sendInviteSignalBackgroundView.centerYAnchor).isActive = true
        sendInviteSignalButton.heightAnchor.constraint(equalTo: sendInviteSignalBackgroundView.heightAnchor, multiplier: 0.6).isActive = true
        sendInviteSignalButton.widthAnchor.constraint(equalTo: sendInviteSignalBackgroundView.heightAnchor, multiplier: 0.6).isActive = true
        sendInviteSignalButton.isHidden = true
        
    }
    
    func layoutSelectFriendsView() {
    
        title = "Select Friends"
        
        layoutFriendsTableView()
        
        view.addSubview(sendOnlineSignalButton)
        
        sendOnlineSignalButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.frame.height / -10).isActive = true
        sendOnlineSignalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendOnlineSignalButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        sendOnlineSignalButton.heightAnchor.constraint(equalToConstant: view.frame.height / 13).isActive = true
        
        sendOnlineSignalButton.layer.cornerRadius = 15
        sendOnlineSignalButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: 20)
        sendOnlineSignalButton.setTitleColor(.white, for: .normal)
        sendOnlineSignalButton.layer.shadowRadius = 1.5
        sendOnlineSignalButton.layer.shadowOpacity = 1.0
        sendOnlineSignalButton.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        sendOnlineSignalButton.layer.shadowColor = UIColor(white: 0, alpha: 0.75).cgColor
        sendOnlineSignalButton.titleLabel?.layer.shadowColor = UIColor(white: 0, alpha: 0.85).cgColor
        sendOnlineSignalButton.titleLabel?.layer.shadowOpacity = 1.0
        sendOnlineSignalButton.titleLabel?.layer.shadowRadius = 0.5
        sendOnlineSignalButton.titleLabel?.layer.shadowOffset = CGSize(width: 0.5, height: 1)
        
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
            
            toUserID = FriendSystem.system.friendsList[indexPath.row].uid
            
            
            let id = FriendSystem.system.friendsList[indexPath.row].uid
            let username = FriendSystem.system.friendsList[indexPath.row].username
            toUserUsername = username
            friendsTableView.reloadData()
            
            sendInviteSignalLabel.text = "Tap to invite \(username)"
            sendInviteSignalLabel.font = UIFont(name: "AvenirNext-Heavy", size: 14.5)
            
            print("Value: \(toUserUsername)")

        
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
        
        print("Let's get cooking")
        
    }
    
    
    @objc func sendInvite(_ sender:UITapGestureRecognizer) {
        
        print("Sent invite to: \(toUserID)")
        let sentVC = UserCreatedController()
        sentVC.modalPresentationStyle = .fullScreen
        sentVC.mainLabel.text = "Invite signal has been sent!"
        
//    FriendSystem.system.currentUserRef.child("signals").child("inviteSignal").updateChildValues(["to":toUserID])
        
        FriendSystem.system.getUser(toUserID) { (user) in
            FriendSystem.system.currentUserRef.child("signals").child("inviteSignal").updateChildValues(["toUID":user.uid, "toUsername": user.username])
        }
        
        self.present(sentVC, animated: true, completion: nil)
        
    }
    
}
