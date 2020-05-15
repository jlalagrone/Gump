//
//  DetailExt.swift
//  Gump
//
//  Created by Jordan LaGrone on 5/1/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

extension DetailController {
    
    // Limits promoTextView to 100 characters maximum
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textView.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)

        // make sure the result is under 16 characters
        return updatedText.count <= 100
    }
    
    
    @objc func addGame(_ sender:UIButton) {
        
        let alert = UIAlertController(title: "Add Game", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let addGameAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let text = alert.textFields![0].text!
            print(text)
            
            FriendSystem.system.currentUserRef.child("games").childByAutoId().setValue(text)
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
    
    @objc func updatePromo(_ sender:UIButton) {
        
        let promoText = promoTextView.text
        
        if promoText != "" && promoText!.count <= 100 {
            
            FriendSystem.system.currentUserRef.child("promo").setValue(promoText)
        }
        
        else if promoText!.count > 100 {
            
            let alert = UIAlertController(title: "Promos must contain 100 characters or less!", message: nil, preferredStyle: .alert)
            let continueAction = UIAlertAction(title: "Continue", style: .default)
            alert.addAction(continueAction)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        else if promoText == "" {
            
            FriendSystem.system.currentUserRef.child("promo").setValue("no promo")
        }
        
    }
    
}
