//
//  SignInController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/6/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase


class SignInController: UIViewController {

    var mainTitle:UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "titleLogo")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    var mainLogo:UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "gumdropLogo")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    var emailLabel:DefaultLabel = {
        var label = DefaultLabel(textColor: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1))
        label.text = "Email"
        
        return label
    }()
    
    var emailTextField:DefaultTextField = {
        var textField = DefaultTextField(color: .white, borderColor: UIColor(red: 118.0/255.0, green: 205.0/255.0, blue: 255.0/255.0, alpha: 1).cgColor,placeholderText: "", placeholderLength: 0)
        
        return textField
    }()
    
    var passwordLabel:DefaultLabel = {
        var label = DefaultLabel(textColor: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1))
        label.text = "Password"
        
        return label
    }()
    
    var passwordTextField:DefaultTextField = {
        var textField = DefaultTextField(color: .white, borderColor: UIColor(red: 118.0/255.0, green: 205.0/255.0, blue: 255.0/255.0, alpha: 1).cgColor,placeholderText: "", placeholderLength: 0)
        
        return textField
    }()
    
    var forgotPasswordLabel:DefaultLabel = {
        var label = DefaultLabel(textColor: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1))
        label.text = "Forgot Password?"
        
        return label
    }()
    
    var signInButton:DefaultButton = {
        var button = DefaultButton(backgroundColor: UIColor(red: 118.0/255.0, green: 205.0/255.0, blue: 255.0/255.0, alpha: 1),borderColor: UIColor(red: 184.0/255.0, green: 0.0/255.0, blue: 222.0/255.0, alpha: 1).cgColor ,title: "Sign In")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(animateButton(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(signIn(_:)), for: .touchDown)

        
        
        return button
    }()
    
    var createAccountButton:DefaultButton = {
        var button = DefaultButton(title: "Create Account", textColor: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1))
        button.addTarget(self, action: #selector(animateButton(_:)), for: .touchDown)
        
        return button
    }()
    
    
    @objc func signIn(_ sender:UIButton) {
        
        Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (result, error) in
            
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
        
            let homeController = HomeController()
            let navVC = UINavigationController(rootViewController: homeController)
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true) {
                navVC.navigationController?.navigationBar.topItem?.title = "Home"

            }
            print("User signed in.")
            
            
        }
        
    }
    
    
    @objc func createAccount() {
        let registrationVC = RegistrationController()
        
        self.navigationController?.pushViewController(registrationVC, animated: true)
    }

    // Button that presents AboutController
    var aboutButton:DefaultButton = {
        var button = DefaultButton(title: "What's Gump?", textColor: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1))
        button.addTarget(self, action: #selector(animateButton(_:)), for: .touchDown)
        
        return button
    }()

    func configureButtonActions() {
        
        createAccountButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        
    }
        
    
    func layoutFonts() {
        emailLabel.font = UIFont(name: "AvenirNext-DemiBold", size: view.frame.height/55)
        passwordLabel.font = UIFont(name: "AvenirNext-DemiBold", size: view.frame.height/55)
        forgotPasswordLabel.font = UIFont(name: "AvenirNext-MediumItalic", size: view.frame.height/57.5)
        
        emailTextField.font = UIFont(name: "AvenirNext-MediumItalic", size: view.frame.height/54.5)
        passwordTextField.font = UIFont(name: "AvenirNext-MediumItalic", size: view.frame.height/54.5)
        emailTextField.textColor = .black
        passwordTextField.textColor = .black
        
        //Button fonts
        signInButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: view.frame.height/35)
        createAccountButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: view.frame.height/35)
        aboutButton.titleLabel?.font = UIFont(name: "AvenirNext-BoldItalic", size: view.frame.height/55)
        
    }
    
    func layoutView() {
        
        view.addSubview(mainTitle)
        view.addSubview(mainLogo)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordLabel)
        view.addSubview(signInButton)
        view.addSubview(createAccountButton)
        view.addSubview(aboutButton)
        
        
        mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/23.5).isActive = true
        mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainTitle.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        mainTitle.heightAnchor.constraint(equalToConstant: view.frame.height/9).isActive = true
        
        mainLogo.centerXAnchor.constraint(equalTo: mainTitle.centerXAnchor).isActive = true
        mainLogo.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 3.5).isActive = true
        mainLogo.widthAnchor.constraint(equalToConstant: view.frame.height/9.5).isActive = true
        mainLogo.heightAnchor.constraint(equalTo: mainTitle.heightAnchor).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: mainLogo.bottomAnchor, constant: 17.5).isActive = true
        
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width/1.2).isActive = true
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 2.5).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: view.frame.height/18).isActive = true
        
        emailLabel.leftAnchor.constraint(equalTo: emailTextField.leftAnchor).isActive = true
        
        passwordLabel.leftAnchor.constraint(equalTo: emailLabel.leftAnchor).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 2.5).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: emailLabel.widthAnchor).isActive = true
        
        forgotPasswordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        forgotPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
        
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInButton.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
        signInButton.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: view.frame.height/12.5).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: view.frame.height/15).isActive = true
        
        createAccountButton.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor).isActive = true
        createAccountButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: view.frame.height/20).isActive = true
        
        aboutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        aboutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1)
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        

    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()

        
        // Adds background gradient to SignInController's view
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 255.0/255.0, green: 183.0/255.0, blue: 228.0/255.0, alpha: 0.975).cgColor, UIColor.white.cgColor]
        view.layer.addSublayer(gradientLayer)
        
        layoutView()
        layoutFonts()
        configureButtonActions()
    
    }


}

