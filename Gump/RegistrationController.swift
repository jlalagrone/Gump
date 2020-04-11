//
//  RegistrationController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/10/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    var viewLogo:UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "gumdropLogo")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // Main label that tells user what information to input on the screen
    var mainLabel = DefaultLabel()
    
    var firstNameField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
    var lastNameField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
        
    var continueButton:DefaultButton = {
        var button = DefaultButton(backgroundColor: .white, borderColor: UIColor(red: 184.0/255.0, green: 0.0/255.0, blue: 222.0/255.0, alpha: 1).cgColor, title: "Continue")
        button.setTitleColor(UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), for: .normal)
        
        return button
    }()
 
    func setPlaceholderTexts() {
        
        var firstPlaceholder = NSMutableAttributedString()
        firstPlaceholder = NSMutableAttributedString(string:"First", attributes: [NSAttributedString.Key.font:UIFont(name: "AvenirNext-Medium", size: 16.5)!])
        firstPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range:NSRange(location:0,length:5))
        
        firstNameField.textAlignment = .center
        firstNameField.attributedPlaceholder = firstPlaceholder
        
        var lastPlaceholder = NSMutableAttributedString()
        lastPlaceholder = NSMutableAttributedString(string:"Last", attributes: [NSAttributedString.Key.font:UIFont(name: "AvenirNext-Medium", size: 16.5)!])
        lastPlaceholder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range:NSRange(location:0,length:4))
        
        lastNameField.textAlignment = .center
        lastNameField.attributedPlaceholder = lastPlaceholder
        
    }
    
    func layoutFonts() {
        
        mainLabel.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: view.frame.height/25)
        continueButton.titleLabel?.font = UIFont(name: "BubbleGum", size: view.frame.height/32)
    }
    
    func layoutInitialView() {
        
        view.addSubview(viewLogo)
        view.addSubview(mainLabel)
        view.addSubview(firstNameField)
        view.addSubview(lastNameField)
        view.addSubview(continueButton)
        
        mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/15).isActive = true
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        firstNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstNameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.825).isActive = true
        firstNameField.heightAnchor.constraint(equalToConstant: view.frame.height/12.5).isActive = true
        firstNameField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: view.frame.height/16.5).isActive = true
  
        lastNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lastNameField.widthAnchor.constraint(equalTo: firstNameField.widthAnchor).isActive = true
        lastNameField.heightAnchor.constraint(equalTo: firstNameField.heightAnchor).isActive = true
        lastNameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: view.frame.height/20).isActive = true
        
        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        continueButton.widthAnchor.constraint(equalTo: firstNameField.widthAnchor).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: (view.frame.height / -12.5)).isActive = true
        continueButton.heightAnchor.constraint(equalTo: firstNameField.heightAnchor, multiplier: 0.975).isActive = true
        
        setPlaceholderTexts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(red: 255.0/255.0, green: 125.0/255.0, blue: 206.0/255.0, alpha: 1)
        
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Create Account"
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutInitialView()
        layoutFonts()
        mainLabel.text = "Enter your name"
    }

}
