//
//  DetailController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/21/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

var gameCount = Int()

class DetailController: UIViewController, UITableViewDelegate, UITableViewDataSource, DetailControllerDelegate {
    
    func updateDetailTable() {
        detailTableView.reloadData()
        print("Delegate pushed.")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        FriendSystem.system.currentUserRef.observe(.value) { (snapshot) in
            let value = snapshot.value as! [String:AnyObject]
            let games = value["Games"] as! [String:String]
            
            gameCount = games.count
        }
        
        return gameCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! DetailCell
        
        
        return cell
    }

    var detailTableView:UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        
        return tableView
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
    
    
    
    
    func layoutView() {
        
        view.addSubview(detailTableView)
        view.addSubview(promoTextView)
        
        detailTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        detailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        detailTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailTableView.heightAnchor.constraint(equalToConstant: view.frame.height / 2.75).isActive = true
        
        promoTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        promoTextView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        promoTextView.heightAnchor.constraint(equalToConstant: view.frame.height / 3.75).isActive = true
        promoTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if title == "Games" {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(DetailController.addGame(_:)))
        }
        
        else if title == "Promo" {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(DetailController.addGame(_:)))
        }
        
        else if title == "Account" {
            
        }
        
        view.backgroundColor = lightPinkColor
        layoutView()

        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(DetailCell.self, forCellReuseIdentifier: "cellID")
    }
    


}
