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
        layer.borderWidth = 2
        layer.borderColor = borderColor
        
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
    
    init(color:UIColor,borderColor:CGColor) {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = color
        borderStyle = .roundedRect
        layer.borderColor = borderColor
        layer.borderWidth = 1.25
        font = UIFont(name: "AvenirNext-Medium", size: 15)
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// Default Label UI Object
class DefaultLabel:UILabel {
    
    init(textColor:UIColor) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = textColor
        
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .white
        self.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: fontSize)
    }
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .white
        self.font = UIFont(name: "AvenirNext-Medium", size: 14.5)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
