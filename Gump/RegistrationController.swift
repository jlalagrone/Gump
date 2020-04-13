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
    var mainLabel = DefaultLabel()
    var secondaryLabel = DefaultLabel()
    
    var emailField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
    var passwordField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
    var confirmPasswordField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
    
    var usernameField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
    var firstNameField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
    var lastNameField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
    
    
    // Code for console pickerView
    let consolePicker = UIPickerView()
    var consoleField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
    
    
    // Code for mic pickerView
    let micPicker = UIPickerView()
    var micField = DefaultTextField(color: UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1), borderColor: UIColor.clear.cgColor)
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == micPicker {
            return micPickerOptions.count
        }
        else {
            return consolePickerOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == micPicker {
            micStatus = micPickerOptions[row]
            micField.text = micStatus
        }
        else {
            consoleStatus = consolePickerOptions[row]
            consoleField.text = consoleStatus
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == micPicker {
            return micPickerOptions[row]
        }
        else {
            return consolePickerOptions[row]
        }
    }
 
    
    @objc func dismissedKeyboard() {
        view.endEditing(true)
    }
    
    func createdToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissedKeyboard))
        
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        micField.inputAccessoryView = toolbar
        consoleField.inputAccessoryView = toolbar
        
        
    }
    
    var continueButton:RegistrationButton = {
        var button = RegistrationButton(backgroundColor: .white, borderColor: UIColor(red: 184.0/255.0, green: 0.0/255.0, blue: 222.0/255.0, alpha: 1).cgColor, title: "Continue")
        
        
        return button
    }()
 

    // Function that sizes UI objects fonts appropiately
    func layoutFonts() {
        
        mainLabel.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: view.frame.height/30)
        secondaryLabel.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: view.frame.height/30)
        continueButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: view.frame.height/27.5)
    }
    
    func layoutInitialView() {
        
        view.addSubview(viewLogo)
        view.addSubview(mainLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(confirmPasswordField)
        view.addSubview(usernameField)
        view.addSubview(firstNameField)
        view.addSubview(lastNameField)
        view.addSubview(consoleField)
        view.addSubview(secondaryLabel)
        view.addSubview(micField)
        view.addSubview(continueButton)
        
        mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/15).isActive = true
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.825).isActive = true
        
        emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.825).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: view.frame.height/14.5).isActive = true
        emailField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: view.frame.height/16.5).isActive = true
  
        passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordField.widthAnchor.constraint(equalTo: emailField.widthAnchor).isActive = true
        passwordField.heightAnchor.constraint(equalTo: emailField.heightAnchor).isActive = true
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: view.frame.height/20).isActive = true
        
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

        
        secondaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        secondaryLabel.widthAnchor.constraint(equalTo: mainLabel.widthAnchor).isActive = true
        secondaryLabel.topAnchor.constraint(equalTo: consoleField.bottomAnchor, constant: view.frame.height/25).isActive = true
        secondaryLabel.isHidden = true
        
        micField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        micField.widthAnchor.constraint(equalTo: consoleField.widthAnchor).isActive = true
        micField.heightAnchor.constraint(equalTo: consoleField.heightAnchor).isActive = true
        micField.topAnchor.constraint(equalTo: secondaryLabel.bottomAnchor, constant: view.frame.height/20).isActive = true
        micField.isHidden = true

        
        continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        continueButton.widthAnchor.constraint(equalTo: emailField.widthAnchor).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: (view.frame.height / -12.5)).isActive = true
        continueButton.heightAnchor.constraint(equalTo: emailField.heightAnchor, multiplier: 0.975).isActive = true
        
        setPlaceholderTexts()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(red: 255.0/255.0, green: 125.0/255.0, blue: 206.0/255.0, alpha: 1)
        
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Create Account"
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        continueButton.addTarget(self, action: #selector(registerAccount), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        layoutInitialView()
        layoutFonts()
        
        createdToolbar()
        
        mainLabel.text = "Enter a email and password"
        mainLabel.numberOfLines = 0
        mainLabel.textAlignment = .center
        
        secondaryLabel.text = "Do you have a microphone?"
        secondaryLabel.numberOfLines = 0
        secondaryLabel.textAlignment = .center
        
        micPicker.delegate = self
        micField.inputView = micPicker
        //Customization
        micPicker.backgroundColor = .white
        
        consolePicker.delegate = self
        consoleField.inputView = consolePicker
        consolePicker.backgroundColor = .white
    }

}
