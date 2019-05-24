//
//  MainTabBar.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/14/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation
import UIKit

class MainTabBar:XibUIView{
    
    // Outlets
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var panelView: UIView!
    
    private var isInitialized:Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            addBtn.layer.applySketchShadow(color: UIColor(named: "shadow-normal-purple-2")!, alpha: 0.3, x: 0, y: 8.0, blur: 12.0, spread: 0)
            panelView.backgroundColor = UIColor.white.withAlphaComponent(0.95)
            
            isInitialized = true
        }
    }
}
