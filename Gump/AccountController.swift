//
//  AccountController.swift
//  Gump
//
//  Created by Jordan LaGrone on 5/1/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

class AccountController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tagsLabel = DefaultLabel(title: "TAGS")
    
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! DetailCell
        
        return cell
    }
    
    var emailTitleLabel = DefaultLabel(title: "EMAIL")
    var nameTitleLabel = DefaultLabel(title: "NAME")
    
    var emailLabel = DefaultLabel(textColor: .black)
    var nameLabel = DefaultLabel(textColor: .black)
    
    func getAccountInfo() {
        
        emailLabel.backgroundColor = .white
        emailLabel.font = UIFont(name: "AvenirNext-MediumItalic", size: view.frame.height / 32.5)
        
        nameLabel.backgroundColor = .white
        nameLabel.font = UIFont(name: "AvenirNext-MediumItalic", size: view.frame.height / 32.5)
        
        FriendSystem.system.getCurrentUser { (user) in
            
            self.emailLabel.text = user.email
            self.nameLabel.text = user.fullName
            
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
        emailTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTitleLabel.topAnchor.constraint(equalTo: tagsTable.bottomAnchor, constant: view.frame.height / 25).isActive = true
        
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailLabel.topAnchor.constraint(equalTo: emailTitleLabel.bottomAnchor).isActive = true
        emailLabel.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: view.frame.height / 18.5).isActive = true
        
        nameTitleLabel.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height / 27.5)
        nameTitleLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: view.frame.height / 25).isActive = true
        nameTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: emailLabel.heightAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        getAccountInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutView()
        
        
        tagsTable.delegate = self
        tagsTable.dataSource = self
        tagsTable.register(DetailCell.self, forCellReuseIdentifier: "cellID")
        
        addTagButton.addTarget(self, action: #selector(addTag(_:)), for: .touchDown)
        
    }
    
    @objc func addTag(_ sender:UIButton) {
        print("Added tag.")
    }

}
