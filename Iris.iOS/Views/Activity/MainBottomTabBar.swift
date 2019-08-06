//
//  MainBottomTabBar.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/5/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class MainBottomTabBar: UITabBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    private var isInitialized:Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){

            isInitialized = true
        }
    }
}
