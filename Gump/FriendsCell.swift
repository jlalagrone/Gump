//
//  FriendsCell.swift
//  Gump
//
//  Created by Jordan LaGrone on 5/30/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

class FriendsCell:UICollectionViewCell {
    
    var cardBackgroundView:UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 7
        view.layer.shadowColor = UIColor(white: 0.875, alpha: 0.9).cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 15)
        view.layer.shadowRadius = 12
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
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textColor = .white
        
        return label
    }()
    
    var nameLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = lightPinkColor
        
        return label
    }()
    
    var gamertagLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = lightPinkColor
        label.textAlignment = .left
        
        return label
    }()
    
    var consoleLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .left
        
        return label
    }()
    
    var stackView = UIStackView()
    
    var gamesAction:(() -> Void)!
    var viewGamesButton:UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Games", for: .normal)
        
        return button
    }()
    
    @objc func gamesTapped(_ sender:UIButton) {
        
        gamesAction()
    }
    
    func setGamesFunction(_ function: @escaping () -> Void) {
        self.gamesAction = function
    }
    
    var promoAction:(() -> Void)!
    var viewPromoButton:UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(darkPinkColor, for: .normal)
        button.setTitle("Promo", for: .normal)

        
        return button
    }()
    
    @objc func promoTapped(_ sender:UIButton) {
        
        promoAction()
    }
    
    func setPromoFunction(_ function: @escaping () -> Void) {
        self.promoAction = function
    }
    
    
    var signalAction:(() -> Void)!
    var signalButton:UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(signalBlueColor, for: .normal)
        button.setTitle("Signal", for: .normal)

        
        return button
    }()
    
    @objc func signalTapped(_ sender:UIButton) {
        
        signalAction()
    }
    
    func setSignalFunction(_ function: @escaping () -> Void) {
        self.signalAction = function
    }
    
    func setupCellFonts() {
        
        usernameLabel.font = UIFont(name: "AvenirNext-Medium", size: frame.height / 13.5)
        nameLabel.font = UIFont(name: "AvenirNext-Bold", size: frame.height / 11.5)
        gamertagLabel.font = UIFont(name: "AvenirNext-Bold", size: frame.height / 12.5)
        consoleLabel.font = UIFont(name: "AvenirNext-Bold", size: frame.height / 15)
        viewGamesButton.titleLabel!.font = UIFont(name: "AvenirNext-Heavy", size: frame.height / 12)
        signalButton.titleLabel!.font = UIFont(name: "AvenirNext-Heavy", size: frame.height / 12)
        viewPromoButton.titleLabel!.font = UIFont(name: "AvenirNext-Heavy", size: frame.height / 12)
    }
    
    func setupCellLayout() {
        
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(cardBackgroundView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(gamertagLabel)
        contentView.addSubview(consoleLabel)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(viewGamesButton)
        stackView.addArrangedSubview(signalButton)
        stackView.addArrangedSubview(viewPromoButton)
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        cardBackgroundView.widthAnchor.constraint(equalToConstant: frame.width / 1.15).isActive = true
        cardBackgroundView.heightAnchor.constraint(equalToConstant: frame.height / 1.35).isActive = true
        cardBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cardBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: cardBackgroundView.topAnchor, constant: frame.height / 20).isActive = true
        usernameLabel.widthAnchor.constraint(equalTo: cardBackgroundView.widthAnchor, multiplier: 0.495).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: cardBackgroundView.leftAnchor, constant: frame.width / 25).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: frame.height / 7.5).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: frame.height / 25).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor).isActive = true
        
        gamertagLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: frame.height / 10).isActive = true
        gamertagLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        
        consoleLabel.centerYAnchor.constraint(equalTo: gamertagLabel.centerYAnchor).isActive = true
        consoleLabel.leftAnchor.constraint(equalTo: gamertagLabel.rightAnchor, constant: 5).isActive = true
        
        stackView.rightAnchor.constraint(equalTo: cardBackgroundView.rightAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: cardBackgroundView.heightAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: cardBackgroundView.widthAnchor, multiplier: 0.33).isActive = true
        stackView.topAnchor.constraint(equalTo: cardBackgroundView.topAnchor).isActive = true
        
        setupCellFonts()
      }
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setupCellLayout()
        
        signalButton.addTarget(self, action: #selector(signalTapped(_:)), for: .touchDown)
        viewPromoButton.addTarget(self, action: #selector(promoTapped(_:)), for: .touchDown)
        viewGamesButton.addTarget(self, action: #selector(gamesTapped(_:)), for: .touchDown)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
