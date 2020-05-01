//
//  ProfileExt.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/21/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

extension ProfileController {
    
    @objc func addTapped(_ sender:UIButton) {
        print("Tapped!")

        let alert = UIAlertController(title: "Add Game", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let addGameAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let text = alert.textFields![0].text!
            print(text)
            
            FriendSystem.system.currentUserRef.child("Games").childByAutoId().setValue(text)
        }
        
        let exitAction = UIAlertAction(title: "Close", style: .destructive) { (action) in
            
        }
        
        alert.addAction(exitAction)
        alert.addAction(addGameAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func editTapped(_ sender:UIButton) {
        print("Editing!")
    }
    
    @objc func viewGamesButtonAction(_ sender:UIButton) {
        
        let detailController = DetailController()

        detailController.title = "Games"
        detailController.promoTextView.isHidden = true
        
        title = ""
        
        self.navigationController?.pushViewController(detailController, animated: true)

    }
    
    @objc func viewPromoButtonAction(_ sender:UIButton) {
        
        let detailController = DetailController()

        detailController.title = "Promo"
        detailController.detailTableView.isHidden = true
        
        title = ""
        
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
}
