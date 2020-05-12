//
//  HomeController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/14/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging

class HomeController: UIViewController {

    var ref = Database.database().reference()
    
    var backgroundImage:UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "largeGumdrop")
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.15
        
        return imageView
    }()
    
    var sendSignalButton = HomeButton(image: UIImage(named: "signalIcon")!)
    var viewFriendsButton = HomeButton(image: UIImage(named: "listIcon")!)
    var viewProfileButton = HomeButton(image: UIImage(named: "profileIcon")!)
    var searchButton = HomeButton(image: UIImage(named: "searchIcon")!)

    var sendSignalLabel = UILabel()
    var viewFriendsLabel = UILabel()
    var viewProfileLabel = UILabel()
    var searchLabel = UILabel()
    
    func layoutHomeViewObjects(buttons:[HomeButton], labels:[UILabel]) {
        
        for button in buttons {
            button.layer.cornerRadius = (view.frame.height / 7.5) * 0.5
        }
  
        for label in labels {
            label.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height / 50)
            label.textAlignment = .center
            label.layer.shadowColor = UIColor(white: 0, alpha: 0.75).cgColor
            label.layer.shadowOpacity = 1.0
            label.layer.shadowRadius = 1.0
            label.layer.shadowOffset = CGSize(width: 1, height: 1)
            label.textColor = .white
        }
    }
    
    func layoutView() {
        view.backgroundColor = UIColor(red: 255.0/255.0, green: 125.0/255.0, blue: 206.0/255.0, alpha: 1)
        
        view.addSubview(backgroundImage)
        view.addSubview(searchButton)
        view.addSubview(searchLabel)
        view.addSubview(sendSignalButton)
        view.addSubview(viewFriendsButton)
        view.addSubview(viewProfileButton)
        view.addSubview(sendSignalLabel)
        view.addSubview(viewFriendsLabel)
        view.addSubview(viewProfileLabel)
        
        
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        sendSignalLabel.translatesAutoresizingMaskIntoConstraints = false
        viewProfileLabel.translatesAutoresizingMaskIntoConstraints = false
        viewFriendsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImage.widthAnchor.constraint(equalToConstant: view.frame.width / 2.5).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 12.5).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height / -15).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width / 1.35).isActive = true
        
        searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/15).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: view.frame.height/7.5).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: view.frame.height/7.5).isActive = true
        
        searchLabel.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: view.frame.height / 40).isActive = true
        searchLabel.centerXAnchor.constraint(equalTo: searchButton.centerXAnchor).isActive = true
        
        viewProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width / -4).isActive = true
        viewProfileButton.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: view.frame.height / 20).isActive = true
        viewProfileButton.widthAnchor.constraint(equalTo: searchButton.widthAnchor).isActive = true
        viewProfileButton.heightAnchor.constraint(equalTo: searchButton.heightAnchor).isActive = true
        
        viewProfileLabel.topAnchor.constraint(equalTo: viewProfileButton.bottomAnchor, constant: view.frame.height / 40).isActive = true
        viewProfileLabel.centerXAnchor.constraint(equalTo: viewProfileButton.centerXAnchor).isActive = true
        
        viewFriendsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width / 4).isActive = true
        viewFriendsButton.topAnchor.constraint(equalTo: viewProfileButton.topAnchor).isActive = true
        viewFriendsButton.widthAnchor.constraint(equalTo: searchButton.widthAnchor).isActive = true
        viewFriendsButton.heightAnchor.constraint(equalTo: searchButton.heightAnchor).isActive = true
        
        viewFriendsLabel.centerXAnchor.constraint(equalTo: viewFriendsButton.centerXAnchor).isActive = true
        viewFriendsLabel.topAnchor.constraint(equalTo: viewFriendsButton.bottomAnchor, constant: view.frame.height / 40).isActive = true
        
        sendSignalButton.topAnchor.constraint(equalTo: viewFriendsLabel.bottomAnchor, constant: view.frame.height / 20).isActive = true
        sendSignalButton.centerXAnchor.constraint(equalTo: searchButton.centerXAnchor).isActive = true
        sendSignalButton.widthAnchor.constraint(equalTo: searchButton.widthAnchor).isActive = true
        sendSignalButton.heightAnchor.constraint(equalTo: searchButton.heightAnchor).isActive = true
        
        sendSignalLabel.topAnchor.constraint(equalTo: sendSignalButton.bottomAnchor, constant: view.frame.height / 40).isActive = true
        sendSignalLabel.centerXAnchor.constraint(equalTo: sendSignalButton.centerXAnchor).isActive = true
        
        

        layoutHomeViewObjects(buttons: [sendSignalButton,viewProfileButton,viewFriendsButton,searchButton], labels:[sendSignalLabel,viewProfileLabel,viewFriendsLabel,searchLabel])
    }
    
    
    let navigationBarTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1)]
    
 
    
    override func viewWillAppear(_ animated: Bool) {
        title = "Home"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "signOutIcon"), style: .plain, target: self, action: #selector(signOutTapped(_:)))
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .reply
//            , target: self, action: #selector(signOutTapped(_:)))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token!)")
        
        ref.child("Users").child(Auth.auth().currentUser!.uid).updateChildValues(["fcmToken": "\(token!)"])

        self.navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1)
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(white:1, alpha: 1), NSAttributedString.Key.font:UIFont(name: "AvenirNext-Medium", size: view.frame.height/32.5)!]
        self.navigationController?.navigationBar.tintColor = .white
        
        sendSignalLabel.text = "SEND SIGNAL"
        viewProfileLabel.text = "YOUR PROFILE"
        viewFriendsLabel.text = "FRIENDS LIST"
        searchLabel.text = "SEARCH"
        
        viewFriendsButton.addTarget(self, action: #selector(showFriendsController(_:)), for: .touchDown)
        sendSignalButton.addTarget(self, action: #selector(showSignalTypeController(_:)), for: .touchDown)
        viewProfileButton.addTarget(self, action: #selector(showProfileController(_:)), for: .touchDown)
        searchButton.addTarget(self, action: #selector(showSearchController(_:)), for: .touchDown)
        
        layoutView()
    }
    


}
