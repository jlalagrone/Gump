//
//  AccountController.swift
//  Gump
//
//  Created by Jordan LaGrone on 5/1/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase

class AccountController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tagsLabel = DefaultLabel(title: "Your Gametags")
    
    var addTagButton:UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "addIcon"), for: .normal)
        return button
    }()
    
    var tagsTable:UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        
        
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendSystem.system.gametags.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! DetailCell
        
        let platforms = Array(FriendSystem.system.gametags.keys)
        let gamerTags = Array(FriendSystem.system.gametags.values)
        
        cell.titleLabel.text = "\(platforms[indexPath.row]): \(gamerTags[indexPath.row])"
        
        return cell
    }
    
    var emailTitleLabel = DefaultLabel(title: "Email Address")
    var nameTitleLabel = DefaultLabel(title: "Name")
    
    var emailLabel = DefaultLabel(textColor: .white)
    var nameLabel = DefaultLabel(textColor: .white)
    
    func getAccountInfo() {
        
        
        emailLabel.backgroundColor = darkPinkColor
        emailLabel.textAlignment = .left
        emailLabel.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: view.frame.height / 39.5)
        
        nameLabel.backgroundColor = darkPinkColor
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: view.frame.height / 39.5)
        
        FriendSystem.system.getCurrentUser { (user) in
            
            self.emailLabel.text = "     \(user.email)"
            self.nameLabel.text = "     \(user.fullName)"
            
        }
        
    }
    
    func layoutView() {
        
        view.backgroundColor = lightPinkColor
        view.addSubview(tagsLabel)
        view.addSubview(addTagButton)
        view.addSubview(tagsTable)
        view.addSubview(emailTitleLabel)
        view.addSubview(emailLabel)
        view.addSubview(nameTitleLabel)
        view.addSubview(nameLabel)
        
        tagsLabel.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height / 27.5)
        tagsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 30).isActive = true
        tagsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width / 20).isActive = true
        
        addTagButton.centerYAnchor.constraint(equalTo: tagsLabel.centerYAnchor).isActive = true
        addTagButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: view.frame.width / -20).isActive = true
        addTagButton.heightAnchor.constraint(equalToConstant: view.frame.height / 35).isActive = true
        addTagButton.widthAnchor.constraint(equalToConstant: view.frame.height / 35).isActive = true
        
        tagsTable.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor).isActive = true
        tagsTable.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        tagsTable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tagsTable.heightAnchor.constraint(equalToConstant: view.frame.height / 5.5).isActive = true
        
        emailTitleLabel.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height / 27.5)
        emailTitleLabel.leftAnchor.constraint(equalTo: tagsLabel.leftAnchor).isActive = true
        emailTitleLabel.topAnchor.constraint(equalTo: tagsTable.bottomAnchor, constant: view.frame.height / 25).isActive = true
        
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailLabel.topAnchor.constraint(equalTo: emailTitleLabel.bottomAnchor).isActive = true
        emailLabel.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: view.frame.height / 16).isActive = true
        
        nameTitleLabel.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height / 27.5)
        nameTitleLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: view.frame.height / 25).isActive = true
        nameTitleLabel.leftAnchor.constraint(equalTo: tagsLabel.leftAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: emailLabel.heightAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        getAccountInfo()
    }
    
    func getUserInfo() {
        FriendSystem.system.getCurrentUser { (user) in
            print("Got em \(user.username)")
            self.tagsTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutView()
        
        
        tagsTable.delegate = self
        tagsTable.dataSource = self
        tagsTable.register(DetailCell.self, forCellReuseIdentifier: "cellID")
        
        addTagButton.addTarget(self, action: #selector(addTag(_:)), for: .touchDown)
        

        
    }


}
