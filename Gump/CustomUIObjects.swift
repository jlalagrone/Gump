//
//  CustomUIObjects.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/9/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit


class DefaultButton:UIButton {
    
    init(backgroundColor:UIColor,borderColor:CGColor,title:String) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        layer.borderWidth = 2.5
        layer.borderColor = borderColor
        
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

        
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = color
        borderStyle = .roundedRect
        layer.borderColor = borderColor
        layer.borderWidth = 1.25
        font = UIFont(name: "AvenirNext-Regular", size: 14)
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
    
    let setFont:(UIFont) -> UIFont = { font in
        
        print(font)
        return font
    }
    
    
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
