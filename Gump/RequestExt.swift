//
//  RequestExt.swift
//  Gump
//
//  Created by Jordan LaGrone on 5/4/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit
import Firebase

extension RequestsController {
    
    @objc func acceptRequest(_ sender:UIButton) {
        print("Request accepted!")
    }
    
    @objc func denyRequest(_ sender:UIButton) {
        print("Request denied.")
        
    }
    
}
