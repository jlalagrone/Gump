//
//  RegistrationController.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/10/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase


class RegistrationController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var signUpEmail = String()
    var signUpPassword = String()
    
    var consolePickerOptions = ["PS4", "Xbox One", "PC", "Nintendo Switch"]
    var consoleStatus:String?
    var micPickerOptions = ["Yes", "No"]
    var micStatus:String?
    
    var ref:DatabaseReference?
    
    var viewLogo:UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "gumdropLogo")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // Main label that tells user what information to input on the screen
    var mainLabel = DefaultLabel(title: "Enter an email and password")
    var secondaryLabel = DefaultLabel(title: "Do you have a microphone?")
    
    var emailField = DefaultTextField(color:UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor:UIColor.clear.cgColor,placeholderText:"Email",placeholderLength:5)
    var passwordField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor,placeholderText: "Password",placeholderLength: 8)
    var confirmPasswordField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor,placeholderText: "Re-enter Password", placeholderLength:17)
    
    var hideTextButton:UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "eyeIcon"), for: .normal)
        button.contentMode = .scaleAspectFill
        
        return button
    }()
    
    var usernameField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor,placeholderText: "Username",placeholderLength:8)
    var firstNameField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor,placeholderText: "First",placeholderLength: 5)
    var lastNameField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor,placeholderText: "Last",placeholderLength: 4)
    
    
    // Code for console pickerView
    let consolePicker = UIPickerView()
    var consoleField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor,placeholderText: "Console",placeholderLength: 7)
    
    var tagField = DefaultTextField(color: darkPinkColor, borderColor: UIColor.clear.cgColor, placeholderText: "Enter Gametag", placeholderLength: 13)
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return consolePickerOptions.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        consoleStatus = consolePickerOptions[row]
        consoleField.text = consoleStatus

    }
    
 
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var attributedString:NSAttributedString!
        
        attributedString = NSAttributedString(string: consolePickerOptions[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        return attributedString
        
    }
  
    // Custom button class object that implements the logic needed to create and sign in the created user
    var continueButton:RegistrationButton = {
        var button = RegistrationButton(backgroundColor: .white, borderColor: UIColor.clear.cgColor, title: "CONTINUE")
        
        return button
    }()
 

    // Function that sizes UI objects fonts appropiately
    func layoutFonts() {
        
        mainLabel.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: view.frame.height/32)
        secondaryLabel.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: view.frame.height/32)
        continueButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: view.frame.height/33)
    }
    
    func layoutView() {
        
//        view.addSubview(viewLogo)
        view.addSubview(mainLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(hideTextButton)
        view.addSubview(confirmPasswordField)
        view.addSubview(usernameField)
        view.addSubview(firstNameField)
        view.addSubview(lastNameField)
        view.addSubview(consoleField)
        view.addSubview(tagField)
        view.addSubview(continueButton)
        
        mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/20).isActive = true
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.825).isActive = true
        
        emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.825).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: view.frame.height/14.5).isActive = true
        emailField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: view.frame.height/16.5).isActive = true
  
        passwordField.leftAnchor.constraint(equalTo: emailField.leftAnchor).isActive = true
        passwordField.widthAnchor.constraint(equalTo: emailField.widthAnchor, multiplier: 0.8).isActive = true
        passwordField.heightAnchor.constraint(equalTo: emailField.heightAnchor).isActive = true
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: view.frame.height/20).isActive = true
        
        hideTextButton.leftAnchor.constraint(equalTo: passwordField.rightAnchor, constant: view.frame.width / 25).isActive = true
        hideTextButton.centerYAnchor.constraint(equalTo: passwordField.centerYAnchor).isActive = true
        hideTextButton.widthAnchor.constraint(equalToConstant: view.frame.height / 28.5).isActive = true
        hideTextButton.heightAnchor.constraint(equalToConstant: view.frame.height / 36.5).isActive = true
        
        confirmPasswordField.centerXAnchor.constraint(equalTo: passwordField.centerXAnchor).isActive = true
        confirmPasswordField.widthAnchor.constraint(equalTo: passwordField.widthAnchor).isActive = true
        confirmPasswordField.heightAnchor.constraint(equalTo: passwordField.heightAnchor).isActive = true
        confirmPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: view.frame.height/20).isActive = true
        
        usernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.825).isActive = true
        usernameField.heightAnchor.constraint(equalToConstant: view.frame.height/14.5).isActive = true
        usernameField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: view.frame.height/16.5).isActive = true
        usernameField.isHidden = true
        
        firstNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstNameField.widthAnchor.constraint(equalTo: usernameField.widthAnchor).isActive = true
        firstNameField.heightAnchor.constraint(equalTo: usernameField.heightAnchor).isActive = true
        firstNameField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: view.frame.height/20).isActive = true
        firstNameField.isHidden = true
        
        lastNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lastNameField.widthAnchor.constraint(equalTo: usernameField.widthAnchor).isActive = true
        lastNameField.heightAnchor.constraint(equalTo: usernameField.heightAnchor).isActive = true
        lastNameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: view.frame.height/20).isActive = true
        lastNameField.isHidden = true
        
        consoleField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        consoleField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.825).isActive = true
        consoleField.heightAnchor.constraint(equalToConstant: view.frame.height/14.5).isActive = true
        consoleField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: view.frame.height/16.5).isActive = true
        consoleField.isHidden = true

        tagField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tagField.widthAnchor.constraint(equalTo: consoleField.widthAnchor).isActive = true
        tagField.heightAnchor.constraint(equalTo: consoleField.heightAnchor).isActive = true
        tagField.topAnchor.constraint(equalTo: consoleField.bottomAnchor, constant: view.frame.height / 20).isActive = true
        tagField.isHidden = true
    
        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        continueButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.825).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: (view.frame.height / -5.5)).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: view.frame.height / 14.5).isActive = true
        
        
        layoutFonts()
    }
    

    
    @objc func keyboardWillShow(_ notification:NSNotification) {
        let userInfo = notification.userInfo
        let keyboardFrame = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        DispatchQueue.main.async {
            if self.confirmPasswordField.isEditing == true || self.lastNameField.isEditing == true {
                       self.view.frame.origin.y -= (keyboardFrame.height/4)
            }
        }
       
    }
    
    @objc func keyboardWillHide(_ notification:NSNotification) {
        let userInfo = notification.userInfo
        let keyboardFrame = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        DispatchQueue.main.async {
            if self.view.frame.origin.y != 0 {
                     self.view.frame.origin.y += (keyboardFrame.height/4)
            }
                 
        }
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(red: 255.0/255.0, green: 125.0/255.0, blue: 206.0/255.0, alpha: 1)
        
        self.navigationController?.navigationBar.isHidden = false
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

        continueButton.addTarget(self, action: #selector(registerAccount), for: .touchUpInside)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255.0/255.0, green: 125.0/255.0, blue: 206.0/255.0, alpha: 1)

        hideKeyboardWhenTappedAround()
        
        layoutView()
   
        consolePicker.delegate = self
        consoleField.inputView = consolePicker
        consolePicker.backgroundColor = .white
        
        hideTextButton.addTarget(self, action: #selector(hideAndShowText(_:)), for: .touchDown)
        
        // Code that adds observers to the displaying/hidding of the keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegistrationController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        

    }

}
