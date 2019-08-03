//
//  UserCenterStatusHeaderView.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 7/4/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class UserCenterStatusHeaderView: XibUIView {
    
    var isInitialized:Bool = false

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            
            isInitialized = true
        }
    }
    
}
