//
//  HomeExt.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/15/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

class HomeButton:UIButton {
    
    var buttonImage:UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.shadowOffset = CGSize(width: 1, height: 1)
        imageView.layer.shadowColor = UIColor(white: 0, alpha: 0.8).cgColor
        imageView.layer.shadowRadius = 1.5
        imageView.layer.shadowOpacity = 1.0
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    

    func layoutButton() {
        addSubview(buttonImage)
        
        
        buttonImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        buttonImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        buttonImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        buttonImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
    }
    
    init(image:UIImage) {
        super.init(frame: .zero)
        
        layoutButton()
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1)
        layer.shadowRadius = 1.5
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.shadowColor = UIColor(white: 0, alpha: 0.75).cgColor
        addTarget(self, action: #selector(animateButton(_:)), for: .touchDown)
        buttonImage.image = image

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// Methods that present next view controller once a home button is tapped
extension HomeController {
    
    
    @objc func showFriendsController(_ sender:UIButton) {
        print("Showing friends controller")
        
        let friendsController = FriendsController()
        self.navigationController?.pushViewController(friendsController, animated: true)
        self.title = "Back"
    }
    
    @objc func showSignalTypeController(_ sender:UIButton) {
        
        let signalController = SignalTypeController()
        self.navigationController?.pushViewController(signalController, animated: true)
        self.title = ""
        
        
    }
    
}



extension UIView {
    
    @objc func animateButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2,
        animations: {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        },
        completion: { _ in
            UIView.animate(withDuration: 0.2) {
                sender.transform = CGAffineTransform.identity
                
                
            }
        })
    }

}
