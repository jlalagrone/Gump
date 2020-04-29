//
//  SearchController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/28/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

class SearchController: UIViewController {

    var searchTable:UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return tableView
    }()
    
    var searchBar:UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = lightPinkColor
        view.layer.cornerRadius = 7.5
        
        return view
    }()
    
    var searchIcon:UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "searchIcon")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    var searchField = DefaultTextField(color: .white, borderColor: UIColor(white: 0.9, alpha: 1).cgColor, placeholderText: "Enter Username", placeholderLength: 14)
    
    func layoutView() {
        
        view.addSubview(searchBar)
        view.addSubview(searchIcon)
        view.addSubview(searchField)
        view.addSubview(searchTable)
        
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: view.frame.width / 1.1).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: view.frame.height / 11).isActive = true
        
        searchIcon.leftAnchor.constraint(equalTo: searchBar.leftAnchor, constant: view.frame.width / 25).isActive = true
        searchIcon.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true
        searchIcon.heightAnchor.constraint(equalTo: searchBar.heightAnchor, multiplier: 0.75).isActive = true
        searchIcon.widthAnchor.constraint(equalTo: searchBar.heightAnchor, multiplier: 0.75).isActive = true
        
        searchField.leftAnchor.constraint(equalTo: searchIcon.rightAnchor, constant: view.frame.width / 25).isActive = true
        searchField.rightAnchor.constraint(equalTo: searchBar.rightAnchor, constant: view.frame.width / -25).isActive = true
        searchField.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true
        searchField.layer.cornerRadius = (view.frame.width / 10) * 0.5
        searchField.borderStyle = .roundedRect
        searchField.heightAnchor.constraint(equalTo: searchBar.heightAnchor, multiplier: 0.65).isActive = true
        
        searchTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        searchTable.widthAnchor.constraint(equalToConstant: view.frame.width / 1.1).isActive = true
        searchTable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height / -20).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search"
        layoutView()
    }
    


}
