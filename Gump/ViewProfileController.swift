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
        imageView.alpha = 0.20
        
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
        
        consoleTitle.text = "Primary Console"
        consoleTitle.font = UIFont(name: "AvenirNext-Bold", size: view.frame.height / 30)
        
        promoLabel.font = UIFont(name: "AvenirNext-DemiBold", size: view.frame.height / 32.5)
        
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
        
        promoView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: view.frame.height / 20).isActive = true
        promoView.widthAnchor.constraint(equalToConstant: view.frame.width / 1.35).isActive = true
        promoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        promoLabel.numberOfLines = 0
        promoLabel.topAnchor.constraint(equalTo: promoView.topAnchor, constant: view.frame.height / 30).isActive = true
        promoLabel.widthAnchor.constraint(equalTo: promoView.widthAnchor, multiplier: 0.85).isActive = true
        promoLabel.centerXAnchor.constraint(equalTo: promoView.centerXAnchor).isActive = true
        
        promoView.bottomAnchor.constraint(equalTo: promoLabel.bottomAnchor, constant: 20).isActive = true
        
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
        
    }
    


}
