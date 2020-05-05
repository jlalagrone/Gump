//
//  RequestsController.swift
//  Gump
//
//  Created by Jordan LaGrone on 5/4/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

class RequestsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var requestTable:UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.frame.height / 10.5)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! RequestCell
        
        return cell
    }
    
    func layoutView() {
        
        view.backgroundColor = lightPinkColor
        view.addSubview(requestTable)
        
        requestTable.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        requestTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        requestTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutView()

        requestTable.delegate = self
        requestTable.dataSource = self
        requestTable.register(RequestCell.self, forCellReuseIdentifier: "cellID")
        
    }
    

 
}
