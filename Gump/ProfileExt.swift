//
//  ProfileExt.swift
//  Gump
//
//  Created by Jordan LaGrone on 4/21/20.
//  Copyright © 2020 JordanLaGrone. All rights reserved.
//

import UIKit

extension ProfileController {
    
    @objc func viewGamesButtonAction(_ sender:UIButton) {
        
        let detailController = DetailController()
        self.navigationController?.pushViewController(detailController, animated: true)
        
        title = "Profile"
        
    }
    
    
    
}
