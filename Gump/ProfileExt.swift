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

    }
    
    @objc func editTapped(_ sender:UIButton) {
        print("Editing!")
    }
    
    @objc func viewGamesButtonAction(_ sender:UIButton) {
        
        let detailController = DetailController()

        detailController.title = "Games"
        detailController.promoTextView.isHidden = true
        detailController.getGames()
        
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
    
    @objc func viewAccountButtonAction(_ sender:UIButton) {
        
        let accountController = AccountController()
        accountController.title = "Account"
        
        title = ""
        
        self.navigationController?.pushViewController(accountController, animated: true)
        
    }
    
    @objc func viewFriendRequestsButtonAction(_ sender:UIButton) {
        
        let requestController = RequestsController()
        requestController.title = "Friend Requests"
        
        title = ""
        
        self.navigationController?.pushViewController(requestController, animated: true)
        
    }
}
