//
//  DetailController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/21/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

var gameCount = Int()

class DetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return FriendSystem.system.gameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! DetailCell
        
        cell.titleLabel.text = FriendSystem.system.gameList[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 11.5
    }
    
    var detailTableView:UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
                
        return tableView
    }()
    
    var helpButton:DefaultButton = {
        var button = DefaultButton(title: "", textColor: UIColor.clear)
        button.setImage(UIImage(named: "helpIcon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    var promoTextView:UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        
        let customToolbar:() -> (UIToolbar) = {
            var toolbar = UIToolbar()
            toolbar.translatesAutoresizingMaskIntoConstraints = false
            toolbar.sizeToFit()
            
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: #selector(hideKeyboard))
            
            toolbar.setItems([flexibleSpace,doneButton], animated: false)
            toolbar.isUserInteractionEnabled = true
            
            return toolbar
           
        }
        
        textView.inputAccessoryView = customToolbar()
        
        return textView
    }()
    
    
    func layoutHelpButton() {
        
        view.addSubview(helpButton)
        helpButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        helpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        if title == "Games" {
            helpButton.topAnchor.constraint(equalTo: detailTableView.bottomAnchor, constant: view.frame.height / 30).isActive = true
            helpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            helpButton.addTarget(self, action: #selector(displayGamesHelpAlert(_:)), for: .touchDown)
        }
        
        else if title == "Promo" {
            
            helpButton.topAnchor.constraint(equalTo: promoTextView.bottomAnchor, constant: view.frame.height / 30).isActive = true
            helpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            helpButton.addTarget(self, action: #selector(displayPromoHelpAlert(_:)), for: .touchDown)
        }
        
    }
    
    func layoutView() {
                
        view.addSubview(detailTableView)
        view.addSubview(promoTextView)
        
        
        detailTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        detailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        detailTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailTableView.heightAnchor.constraint(equalToConstant: view.frame.height / 2.5).isActive = true
        
        
        promoTextView.font = UIFont(name: "AvenirNext-DemiBold", size: view.frame.height / 37.5)
        promoTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        promoTextView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        promoTextView.heightAnchor.constraint(equalToConstant: view.frame.height / 4.5).isActive = true
        promoTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if title == "Games" {
        
            FriendSystem.system.getCurrentUser { (user) in
                print("Got user \(user.username)")
            
                if let games = user.games {
                    FriendSystem.system.gameList = Array(games.values)
                }
                
            }
            
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(DetailController.addGame(_:)))
            
        }
        
        else if title == "Promo" {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(DetailController.updatePromo(_:)))
            
            FriendSystem.system.currentUserRef.observeSingleEvent(of: .value) { (snapshot) in
                let userDict = snapshot.value as! [String:AnyObject]
                let promo = userDict["promo"] as! String
                
                if promo == "no promo" {
                    self.promoTextView.text = ""
                } else {
                    self.promoTextView.text = promo

                }
                
            }
        }

        
        view.backgroundColor = lightPinkColor
        layoutView()
        layoutHelpButton()

        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(DetailCell.self, forCellReuseIdentifier: "cellID")
    }
    


}
