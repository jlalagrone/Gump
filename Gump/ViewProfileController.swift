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
        
        FriendSystem.system.getUser(profileID) { (user) in
            self.usernameLabel.text = user.username
            self.nameLabel.text = user.fullName
            
            let consoles = Array(user.gametags!.keys)
            self.consoleLabel.text = consoles[0]
            
        }
        
    }
    
    func layoutView() {
        
        view.backgroundColor = .white
        
        view.addSubview(backgroundImage)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(promoView)
        view.addSubview(promoLabel)
        
        usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 20).isActive = true
        usernameLabel.widthAnchor.constraint(equalToConstant: view.frame.width / 1.25).isActive = true
        
        
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
