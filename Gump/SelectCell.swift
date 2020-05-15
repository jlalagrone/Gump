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
        
        addSubview(usernameLabel)
        addSubview(chosenView)
        
        usernameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width / 10).isActive = true
        usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        usernameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: frame.height / 2.25)
        
        chosenView.rightAnchor.constraint(equalTo: rightAnchor, constant: frame.width / -10).isActive = true
        chosenView.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        chosenView.heightAnchor.constraint(equalToConstant: frame.height / 2.5).isActive = true
        chosenView.widthAnchor.constraint(equalToConstant: frame.height / 2.5).isActive = true
        chosenView.layer.cornerRadius = (frame.height / 2.5) * 0.5
        
        
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
           
         layoutCell()
           
       }
     
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    

    }
    
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}
