//
//  DetailExt.swift
//  Gump
//
//  Created by Jordan LaGrone on 5/1/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

extension DetailController {
    
    @objc func addGame(_ sender:UIButton) {
        
        let alert = UIAlertController(title: "Add Game", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let addGameAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let text = alert.textFields![0].text!
            print(text)
            
            FriendSystem.system.currentUserRef.child("Games").childByAutoId().setValue(text)
            print("The game \(text) has been added to your library.")
            
            FriendSystem.system.gameList.append(text)
            self.detailTableView.reloadData()
        }
        
        let exitAction = UIAlertAction(title: "Close", style: .destructive) { (action) in
            
        }
        
        alert.addAction(exitAction)
        alert.addAction(addGameAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}
