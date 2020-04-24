//
//  SignalTypeController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/17/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase

class SignalTypeController: UIViewController {

    var onlineSignalButton = HomeButton(image: UIImage(named: "signalIcon")!)
    var inviteSignalButton = HomeButton(image: UIImage(named: "signalIcon")!)
    
    var mainLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select signal type"
        label.textColor = .white
        
        return label
    }()
    
    var onlineSignalLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ONLINE"
        
        return label
    }()
    
    var inviteSignalLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "INVITE"
        
        return label
    }()
    
    func layoutSignalButtons(buttons:[HomeButton],labels:[UILabel]) {
        
        mainLabel.font = UIFont(name: "AvenirNext-Medium", size: view.frame.height / 28)
        
        for button in buttons {
            button.layer.cornerRadius = (view.frame.height / 6.5) * 0.5
            button.setTitleColor(.white, for: .normal)
        }
        
        for label in labels {
            label.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height / 32.5)
            label.textColor = .white
            label.textAlignment = .center
            label.layer.shadowColor = UIColor(white: 0, alpha: 0.75).cgColor
            label.layer.shadowOpacity = 1.0
            label.layer.shadowRadius = 1.0
            label.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
        
    }
    
    func layoutView() {
        
        view.backgroundColor = lightPinkColor
        
        view.addSubview(mainLabel)
        view.addSubview(onlineSignalLabel)
        view.addSubview(inviteSignalLabel)
        view.addSubview(onlineSignalButton)
        view.addSubview(inviteSignalButton)
        
        mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 15).isActive = true
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        onlineSignalButton.widthAnchor.constraint(equalToConstant: view.frame.height/6.5).isActive = true
        onlineSignalButton.heightAnchor.constraint(equalToConstant: view.frame.height/6.5).isActive = true
        onlineSignalButton.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: view.frame.height / 12.5).isActive = true
        onlineSignalButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width / 7).isActive = true
        
        onlineSignalLabel.leftAnchor.constraint(equalTo: onlineSignalButton.rightAnchor, constant: view.frame.width / 23.5).isActive = true
        onlineSignalLabel.centerYAnchor.constraint(equalTo: onlineSignalButton.centerYAnchor).isActive = true
        
        inviteSignalButton.leftAnchor.constraint(equalTo: onlineSignalButton.leftAnchor).isActive = true
        inviteSignalButton.widthAnchor.constraint(equalToConstant: view.frame.height/6.5).isActive = true
        inviteSignalButton.heightAnchor.constraint(equalToConstant: view.frame.height/6.5).isActive = true
        inviteSignalButton.topAnchor.constraint(equalTo: onlineSignalButton.bottomAnchor, constant: view.frame.height / 15).isActive = true
        
        inviteSignalLabel.leftAnchor.constraint(equalTo: onlineSignalLabel.leftAnchor).isActive = true
        inviteSignalLabel.centerYAnchor.constraint(equalTo: inviteSignalButton.centerYAnchor).isActive = true
        
        layoutSignalButtons(buttons: [onlineSignalButton,inviteSignalButton],labels:[onlineSignalLabel,inviteSignalLabel])
        
        
    }
    
    @objc func showOnlineSignalController(_ sender:UIButton) {
        print("Online signal")
        
        let signalController = SignalController()
        self.navigationController?.pushViewController(signalController, animated: true)
        
        title = ""
        
        signalController.layoutOnlineSignalView()
        signalController.mainLabel.text = "Online Signal"
        
    }
    
    @objc func showInviteSignalController(_ sender:UIButton) {
        
        // Code that executes when a user starts to create an invite signal
        print("Invite signal")
        
        let signalController = SignalController()
        self.navigationController?.pushViewController(signalController, animated: true)
        
        title = ""
        
        signalController.layoutInviteSignalView()
        signalController.mainLabel.text = "Invite Signal"
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutView()
        
        onlineSignalButton.addTarget(self, action: #selector(showOnlineSignalController(_:)), for: .touchDown)
        inviteSignalButton.addTarget(self, action: #selector(showInviteSignalController(_:)), for: .touchDown)


    }
    


}
