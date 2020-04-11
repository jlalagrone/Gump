//
//  RegistrationController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/10/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {

    var topViewBar:UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1)
        
        return view
    }()
    
    var viewLogo:UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "gumdropLogo")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    
    func layoutInitialView() {
//        view.addSubview(topViewBar)
        view.addSubview(viewLogo)
        
//        topViewBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        topViewBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
//        topViewBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        topViewBar.heightAnchor.constraint(equalToConstant: view.frame.height/10).isActive = true
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        layoutInitialView()
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
