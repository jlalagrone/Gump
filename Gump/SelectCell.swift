//
//  SelectCell.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/19/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

class SelectCell:UITableViewCell {
    
    var chosen:Bool = false
    
    var userImage:UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cellUser")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    var usernameLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        
        return label
        
    }()
    
    var chosenView:UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        view.isHidden = true
        return view
    }()
 
    
    func layoutCell() {
     
        backgroundColor = .white
        
        addSubview(userImage)
        addSubview(usernameLabel)
        addSubview(chosenView)
        
        userImage.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width / 17.5).isActive = true
        userImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: frame.height / 1.75).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: frame.height / 1.75).isActive = true
        
        usernameLabel.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: frame.width / 25).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        usernameLabel.font = UIFont(name: "AvenirNext-Medium", size: frame.height / 2.75)
        
        chosenView.rightAnchor.constraint(equalTo: rightAnchor, constant: frame.width / -12.5).isActive = true
        chosenView.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        chosenView.heightAnchor.constraint(equalToConstant: frame.height / 2.5).isActive = true
        chosenView.widthAnchor.constraint(equalToConstant: frame.height / 2.5).isActive = true
        chosenView.layer.cornerRadius = (frame.height / 2.5) * 0.5
        
        usernameLabel.rightAnchor.constraint(equalTo: chosenView.leftAnchor, constant: 2.5).isActive = true
        
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
           
         layoutCell()
           
       }
     
    
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}
