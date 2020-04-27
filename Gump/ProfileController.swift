//
//  ProfileController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/19/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UIViewController {
    
    var username = String()

    var mainLabel = DefaultLabel(title: "")
    func getUsername() {
        
        // Format profile view with user's information
        FriendSystem.system.getCurrentUser { (user) in
            self.username = user.username
            print("User: \(self.username)")
           
            var attributedText = NSMutableAttributedString(string: self.username, attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor : UIColor.white])
            
            self.mainLabel.attributedText = attributedText
            
            
        }
        
    }
    
    
    var viewGamesLabel = DefaultLabel(title: "Your Games")
    var viewFriendsLabel = DefaultLabel(title: "Your Friends")
    var viewPromoLabel = DefaultLabel(title: "Your Promo")
    var accountInfoLabel = DefaultLabel(title: "Account Info")
    
    
    var viewGamesButton = HomeButton(image: UIImage(named: "gameIcon")!)
    var viewFriendsButton = HomeButton(image: UIImage(named:"listIcon")!)
    var viewPromoButton = HomeButton(image: UIImage(named: "chatIcon")!)
    var accountInfoButton = HomeButton(image: UIImage(named: "gearIcon")!)
    
    
    func layoutProfileObjects(buttons: [UIButton],labels:[UILabel]) {
        
        for button in buttons {
            button.layer.cornerRadius = (view.frame.height / 9.5) * 0.5
        }
        
        for label in labels {
            label.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height / 35)
            label.textAlignment = .center
            label.layer.shadowColor = UIColor(white: 0, alpha: 0.75).cgColor
            label.layer.shadowOpacity = 1.0
            label.layer.shadowRadius = 1.0
            label.layer.shadowOffset = CGSize(width: 1, height: 1)
            label.textColor = .white
        }
        
        
    }
        
   
    
    
    
    
    func layoutView() {
        
        view.backgroundColor = lightPinkColor
        
        view.addSubview(mainLabel)
        view.addSubview(viewGamesLabel)
        view.addSubview(viewFriendsLabel)
        view.addSubview(viewPromoLabel)
        view.addSubview(accountInfoLabel)
        view.addSubview(viewGamesButton)
        view.addSubview(viewFriendsButton)
        view.addSubview(viewPromoButton)
        view.addSubview(accountInfoButton)
        
        getUsername()
        
        mainLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width / 10).isActive = true
        mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 30).isActive = true
        mainLabel.font = UIFont(name: "AvenirNext-BoldItalic", size: view.frame.height / 20)
        
        viewGamesLabel.leftAnchor.constraint(equalTo: mainLabel.leftAnchor, constant: view.frame.width / 7.5).isActive = true
        viewGamesLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: view.frame.height / 16.5).isActive = true
        
        viewGamesButton.leftAnchor.constraint(equalTo: viewGamesLabel.rightAnchor, constant: view.frame.width / 15).isActive = true
        viewGamesButton.widthAnchor.constraint(equalToConstant: view.frame.height / 9.5).isActive = true
        viewGamesButton.heightAnchor.constraint(equalToConstant: view.frame.height / 9.5).isActive = true
        viewGamesButton.centerYAnchor.constraint(equalTo: viewGamesLabel.centerYAnchor).isActive = true
        
        viewFriendsButton.topAnchor.constraint(equalTo: viewGamesButton.bottomAnchor, constant: view.frame.height / 25).isActive = true
        viewFriendsButton.widthAnchor.constraint(equalToConstant: view.frame.height / 9.5).isActive = true
        viewFriendsButton.heightAnchor.constraint(equalToConstant: view.frame.height / 9.5).isActive = true
        viewFriendsButton.centerXAnchor.constraint(equalTo: viewGamesButton.centerXAnchor).isActive = true
        
        viewFriendsLabel.leftAnchor.constraint(equalTo: viewGamesLabel.leftAnchor).isActive = true
        viewFriendsLabel.centerYAnchor.constraint(equalTo: viewFriendsButton.centerYAnchor).isActive = true
        
        viewPromoButton.centerXAnchor.constraint(equalTo: viewFriendsButton.centerXAnchor).isActive = true
        viewPromoButton.topAnchor.constraint(equalTo: viewFriendsButton.bottomAnchor, constant: view.frame.height / 25).isActive = true
        viewPromoButton.widthAnchor.constraint(equalTo: viewFriendsButton.widthAnchor).isActive = true
        viewPromoButton.heightAnchor.constraint(equalTo: viewFriendsButton.heightAnchor).isActive = true
        
        viewPromoLabel.leftAnchor.constraint(equalTo: viewGamesLabel.leftAnchor).isActive = true
        viewPromoLabel.centerYAnchor.constraint(equalTo: viewPromoButton.centerYAnchor).isActive = true
        
        accountInfoButton.centerXAnchor.constraint(equalTo: viewGamesButton.centerXAnchor).isActive = true
        accountInfoButton.topAnchor.constraint(equalTo: viewPromoButton.bottomAnchor, constant: view.frame.height / 25).isActive = true
        accountInfoButton.widthAnchor.constraint(equalTo: viewPromoButton.widthAnchor).isActive = true
        accountInfoButton.heightAnchor.constraint(equalTo: viewPromoButton.heightAnchor).isActive = true
        
        accountInfoLabel.leftAnchor.constraint(equalTo: viewGamesLabel.leftAnchor).isActive = true
        accountInfoLabel.centerYAnchor.constraint(equalTo: accountInfoButton.centerYAnchor).isActive = true
        
        
        layoutProfileObjects(buttons: [viewGamesButton,viewFriendsButton,viewPromoButton,accountInfoButton], labels: [viewGamesLabel,viewFriendsLabel,viewPromoLabel,accountInfoLabel])
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutView()
       
        viewGamesButton.addTarget(self, action: #selector(viewGamesButtonAction(_:)), for: .touchDown)

    }
    


}