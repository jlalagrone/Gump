//
//  UserCreatedController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/13/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

class UserCreatedController: UIViewController {

    var mainLabel = DefaultLabel(title: "Congratulations, your Gump account has been created!")
    
    
    var mainImage:UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "finishedCheckMark")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    var proceedButton = DefaultButton(textColor: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), title: "Continue")
    
    var aboutButton = DefaultButton(title: "How To Use Gump", textColor: .white)

    func layoutFonts() {
        mainLabel.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: view.frame.height/27.5)
        proceedButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: view.frame.height/33)
        aboutButton.titleLabel?.font = UIFont(name: "AvenirNext-BoldItalic", size: view.frame.height/53.5)
    }
    
    func layoutView() {
        view.backgroundColor = UIColor(red: 255.0/255.0, green: 125.0/255.0, blue: 206.0/255.0, alpha: 1)
        
        view.addSubview(mainLabel)
        view.addSubview(mainImage)
        view.addSubview(proceedButton)
        view.addSubview(aboutButton)
        
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/17).isActive = true
        mainLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        mainImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainImage.widthAnchor.constraint(equalToConstant: view.frame.width/3.5).isActive = true
        mainImage.heightAnchor.constraint(equalToConstant: view.frame.height/4.5).isActive = true
        mainImage.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: view.frame.height/25).isActive = true
        
        proceedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        proceedButton.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: view.frame.height/15).isActive = true
        proceedButton.widthAnchor.constraint(equalTo: mainLabel.widthAnchor).isActive = true
        proceedButton.heightAnchor.constraint(equalToConstant: view.frame.height/15).isActive = true
        
        aboutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        aboutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.frame.height / -27.5).isActive = true
        
        layoutFonts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutView()
        
    }
    


}
