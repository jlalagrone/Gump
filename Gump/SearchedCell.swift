//
//  SearchedCell.swift
//  Gump
//
//  Created by Jordan LaGrone on 6/3/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase

class SearchedCell:UICollectionViewCell {
        
    var cardBackgroundView:UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 7
        view.layer.shadowColor = UIColor(white: 0.45, alpha: 0.5).cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 3.5)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.9
        view.layer.borderWidth = 0.4
        view.layer.borderColor = UIColor(white: 0.85, alpha: 1).cgColor
        
        return view
    }()
    
    var usernameLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = darkPinkColor
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.textColor = .white
        
        return label
    }()
    
    var nameLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = lightPinkColor
        
        return label
    }()
    
    var stackView = UIStackView()
    
    var profileAction: (() -> Void)!
    var viewProfileButton:UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = lightPinkColor
        button.setTitleColor(.white, for: .normal)
        button.setTitle("View Profile", for: .normal)
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    @objc func profileTapped(_ sender:UIButton) {
        
        profileAction()
    }
    
    func setProfileFunction(_ function: @escaping () -> Void) {
        self.profileAction = function
    }
    
    var requestAction: (() -> Void)!
    var sendRequestButton:UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = signalBlueColor
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitle("Send Request", for: .normal)

        
        return button
    }()
    
    @objc func requestTapped(_ sender:UIButton) {
        
        requestAction()
    }
    
    func setRequestFunction(_ function: @escaping () -> Void) {
        self.requestAction = function
    }
    
    func layoutProperties() {
        
        sendRequestButton.addTarget(self, action: #selector(requestTapped(_:)), for: .touchDown)
        viewProfileButton.addTarget(self, action: #selector(profileTapped(_:)), for: .touchDown)
    }
    
    func setupCellFonts() {
         
        usernameLabel.font = UIFont(name: "AvenirNext-Medium", size: frame.height / 10)
        nameLabel.font = UIFont(name: "AvenirNext-Bold", size: frame.height / 8.5)
        
        viewProfileButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: frame.height / 12)
        sendRequestButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: frame.height / 12)
        
        layoutProperties()
     }
    
    func setupCellLayout() {
        
        contentView.backgroundColor = .clear
        contentView.addSubview(cardBackgroundView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(stackView)
        
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(viewProfileButton)
        stackView.addArrangedSubview(sendRequestButton)
        
        cardBackgroundView.widthAnchor.constraint(equalToConstant: frame.width / 1.15).isActive = true
        cardBackgroundView.heightAnchor.constraint(equalToConstant: frame.height / 1.35).isActive = true
        cardBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cardBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
         
        usernameLabel.topAnchor.constraint(equalTo: cardBackgroundView.topAnchor, constant: frame.height / 20).isActive = true
        usernameLabel.widthAnchor.constraint(equalTo: cardBackgroundView.widthAnchor, multiplier: 0.55).isActive = true
        usernameLabel.centerXAnchor.constraint(equalTo: cardBackgroundView.centerXAnchor).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: frame.height / 7.5).isActive = true
         
        nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: frame.height / 20).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: usernameLabel.centerXAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: usernameLabel.heightAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: cardBackgroundView.widthAnchor, multiplier: 0.85).isActive = true
        
        stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: frame.height / 7).isActive = true
        stackView.bottomAnchor.constraint(equalTo: cardBackgroundView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: cardBackgroundView.widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: cardBackgroundView.centerXAnchor).isActive = true
        
        setupCellFonts()
    }
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupCellLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
