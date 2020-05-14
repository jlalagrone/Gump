//
//  ViewProfileController.swift
//  Gump
//
//  Created by Jordan LaGrone on 5/13/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

class ViewProfileController: UIViewController {

    var profileID:String!
    
    var usernameLabel = DefaultLabel(textColor: darkPinkColor)
    var nameLabel = DefaultLabel(textColor: lightPinkColor)
    var promoLabel = DefaultLabel(textColor: .white)
    var consoleTitle = DefaultLabel(textColor: darkPinkColor)
    var consoleLabel = DefaultLabel(textColor: signalBlueColor)
    
    var sendFriendRequestButton:DefaultButton = {
        var button = DefaultButton(backgroundColor: darkPinkColor, borderColor: UIColor.clear.cgColor, title: "SEND FRIEND REQUEST")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = darkPinkColor
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    var consoleIcon:UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "smallPinkConsoleIcon")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    var backgroundImage:UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "largeBlueGumdrop")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.235
        
        return imageView
    }()
    
    var promoView:UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = lightPinkColor
        
        return view
    }()
    
    func getSearchedUser() {
        
        usernameLabel.font = UIFont(name: "AvenirNext-BoldItalic", size: view.frame.height / 22.5)
        nameLabel.font = UIFont(name: "AvenirNext-Bold", size: view.frame.height / 30)
        consoleLabel.font = UIFont(name: "AvenirNext-BoldItalic", size: view.frame.height / 23)
        sendFriendRequestButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: 20)
        
        consoleTitle.text = "Primary Console"
        consoleTitle.font = UIFont(name: "AvenirNext-Bold", size: view.frame.height / 30)
        
        promoLabel.font = UIFont(name: "AvenirNext-DemiBold", size: view.frame.height / 36.5)
        
        FriendSystem.system.getUser(profileID) { (user) in
            self.usernameLabel.text = user.username
            self.nameLabel.text = user.fullName
            
            let consoles = Array(user.gametags!.keys)
            self.consoleLabel.text = consoles[0]
            
            let promoText = user.promo
            
            if promoText == "no promo" {
                self.promoLabel.text = "This user has yet to create their promo message."
            } else {
                self.promoLabel.text = promoText
            }
            
        }
        
    }
    
    func layoutNonFriendView() {
        
        view.addSubview(sendFriendRequestButton)
        
        sendFriendRequestButton.topAnchor.constraint(equalTo: consoleLabel.bottomAnchor, constant: view.frame.height / 9.5).isActive = true
        sendFriendRequestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendFriendRequestButton.widthAnchor.constraint(equalToConstant: view.frame.width / 1.15).isActive = true
        
        sendFriendRequestButton.layer.shadowRadius = 1.5
        sendFriendRequestButton.layer.shadowOpacity = 1.0
        sendFriendRequestButton.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        sendFriendRequestButton.layer.shadowColor = UIColor(white: 0, alpha: 0.75).cgColor
        sendFriendRequestButton.titleLabel?.layer.shadowColor = UIColor(white: 0, alpha: 0.85).cgColor
        sendFriendRequestButton.titleLabel?.layer.shadowOpacity = 1.0
        sendFriendRequestButton.titleLabel?.layer.shadowRadius = 0.5
        sendFriendRequestButton.titleLabel?.layer.shadowOffset = CGSize(width: 0.5, height: 1)
        sendFriendRequestButton.layer.cornerRadius = 15
    
        
    }
    
    func layoutView() {
        
        view.backgroundColor = .white
        
        view.addSubview(backgroundImage)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(promoView)
        view.addSubview(promoLabel)
        view.addSubview(consoleTitle)
        view.addSubview(consoleLabel)
        
        
        usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 20).isActive = true
        usernameLabel.widthAnchor.constraint(equalToConstant: view.frame.width / 1.25).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: -5).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: usernameLabel.centerXAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: usernameLabel.widthAnchor).isActive = true
        
        promoView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: view.frame.height / 23).isActive = true
        promoView.widthAnchor.constraint(equalToConstant: view.frame.width / 1.15).isActive = true
        promoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        promoView.layer.cornerRadius = 7.5
        
        promoLabel.numberOfLines = 0
        promoLabel.topAnchor.constraint(equalTo: promoView.topAnchor, constant: 10).isActive = true
        promoLabel.widthAnchor.constraint(equalTo: promoView.widthAnchor, multiplier: 0.925).isActive = true
        promoLabel.centerXAnchor.constraint(equalTo: promoView.centerXAnchor).isActive = true
        
        promoView.bottomAnchor.constraint(equalTo: promoLabel.bottomAnchor, constant: 10).isActive = true
        
        consoleTitle.topAnchor.constraint(equalTo: promoView.bottomAnchor, constant: view.frame.height / 23).isActive = true
        consoleTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        consoleLabel.topAnchor.constraint(equalTo: consoleTitle.bottomAnchor, constant: 5).isActive = true
        consoleLabel.centerXAnchor.constraint(equalTo: consoleTitle.centerXAnchor).isActive = true
        
        backgroundImage.widthAnchor.constraint(equalToConstant: view.frame.width / 2.5).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 12.5).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height / -15).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width / 1.35).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSearchedUser()
        
        layoutView()
        
        FriendSystem.system.currentUserRef.observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as! [String:AnyObject]
            let username = value["username"] as! String
            let friends = value["friends"] as! [String:Bool]
            
            let friendIDs = Array(friends.keys)
            
            if friendIDs.contains(self.profileID) {
                print("Users are already friends")
            } else {
                self.layoutNonFriendView()
                self.sendFriendRequestButton.addTarget(self, action: #selector(self.sendFriendRequestAction(_:)), for: .touchDown)
            }
            
            print("Friends: \(friends)")
        }
        
    }
    


}
