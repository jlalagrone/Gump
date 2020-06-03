//
//  CustomUIObjects.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/9/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase

let darkPinkColor = UIColor(red: 239.0/255.0, green: 91.0/255.0, blue: 164.0/255.0, alpha: 1)
let lightPinkColor = UIColor(red: 255.0/255.0, green: 125.0/255.0, blue: 206.0/255.0, alpha: 1)
let lightBlueColor = UIColor(red: 118.0/255.0, green: 165.0/255.0, blue: 255.0/255.0, alpha: 1)
let purpleColor = UIColor(red: 184.0/255.0, green: 0.0/255.0, blue: 222.0/255.0, alpha: 1)
let signalBlueColor = UIColor(red: 38.0/255.0, green: 175.0/255.0, blue: 255.0/255.0, alpha: 1)
let backgroundPinkColor = UIColor(red: 255.0/255.0, green: 210.0/255.0, blue: 237.0/255.0, alpha: 1)

class GumpUser {
    var email:String
    var uid:String
    var username:String
    var fullName:String
    var notificationToken:String?
    var promo:String?
    var games:[String:String]?
    var gamertags:[String:String]?
    var requests:[String:Bool]?
    
    init(email:String,uid:String,username:String,fullName:String,promo:String?,games:[String:String]?,gamertags:[String:String]?,requests:[String:Bool]?, notificationToken:String?) {
        self.email = email
        self.uid = uid
        self.username = username
        self.fullName = fullName
        self.promo = promo
        self.games = games
        self.gamertags = gamertags
        self.requests = requests
        self.notificationToken = notificationToken
    }
}


class DefaultButton:UIButton {
    
    init(backgroundColor:UIColor,borderColor:CGColor,title:String) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        layer.borderWidth = 2.5
        layer.borderColor = borderColor
        addTarget(self, action: #selector(animateButton(_:)), for: .touchDown)
    }
    
    convenience init(textColor:UIColor,title:String) {
        self.init(backgroundColor: .white,borderColor: UIColor(red: 118.0/255.0, green: 205.0/255.0, blue: 255.0/255.0, alpha: 1).cgColor ,title: title)
        
        setTitleColor(textColor, for: .normal)
        layer.cornerRadius = 5
        
    }
    
    init(title:String,textColor:UIColor) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitleColor(textColor, for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



class DefaultTextField:UITextField {
    
    // Target action for doneButton inside of customToolbar
    @objc func dismissedKeyboard() {
        endEditing(true)
        
     }
    
    
    // Creates custom toolbar for DefaultTextField's inputAccessoryView
    let customToolbar:() -> (UIToolbar) = {
        var toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: #selector(dismissedKeyboard))
        
        toolbar.setItems([flexibleSpace,doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
       
    }
    
    
    // Closure that creates custom placeholderText for DefaultTextField's attributedPlaceholder propertry
    let placeholderText:(String,Int,UITextField) -> NSMutableAttributedString = { (text,length,textField) in
        
        var placeHolder = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font:UIFont(name: "AvenirNext-Regular", size: 14.5)!])
        placeHolder.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range:NSRange(location:0,length:length))
        
        textField.attributedPlaceholder = placeHolder
        
        return placeHolder
    }
    
    
    init(color:UIColor,borderColor:CGColor,placeholderText:String,placeholderLength:Int) {
        super.init(frame: .zero)
 
        autocorrectionType = .no
        textColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = color
        layer.masksToBounds = true
        borderStyle = .roundedRect
        layer.borderColor = borderColor
        layer.borderWidth = 1.25
        font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        textAlignment = .center
        inputAccessoryView = customToolbar()
        attributedPlaceholder = self.placeholderText(placeholderText,placeholderLength,self)
        
        
        
    }
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// Default Label UI Object
class DefaultLabel:UILabel {

    
    init(textColor:UIColor) {
          super.init(frame: .zero)
          
          translatesAutoresizingMaskIntoConstraints = false
          self.textColor = textColor
          textAlignment = .center
          numberOfLines = 0
          
      }
    
    convenience init(title:String) {
        self.init(textColor: .white)
        
        text = title
        
    }
    

    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .white
        font = UIFont(name: "AvenirNext-DemiBoldItalic", size: fontSize)
    }
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .white
        font = UIFont(name: "AvenirNext-Medium", size: 14.5)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

