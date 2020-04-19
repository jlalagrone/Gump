//
//  SignalControllerExt.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/19/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

extension SignalController {
    
    @objc func chooseFriendToInvite(_ sender:UIButton) {
        
        let selectController = SelectController()
        
        if gameField.text == "" {
            let confirmAlert = UIAlertController(title: "Are you sure you want to send an invite signal with a blank message?", message: "", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
                
                // Execute code that prepares to send invite signal notification to the selected friend with blank message
                self.navigationController?.pushViewController(selectController, animated: true)
                selectController.layoutSelectFriendView()
                
            }
            
            let noAction = UIAlertAction(title: "No", style: .cancel)
            confirmAlert.addAction(noAction)
            confirmAlert.addAction(yesAction)
            
            title = ""
            
            present(confirmAlert, animated: true)
        }
        
        else {
        
        // Execute code that prepares to send invite signal to selected friend
            title = ""
            
            self.navigationController?.pushViewController(selectController, animated: true)
            selectController.layoutSelectFriendView()
            
        }
    }
    
    
}
