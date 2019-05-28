//
//  UserInfoView.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/28/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class UserInfoView: XibUIView {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    private var isInitialized:Bool = false
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
            
            avatarImageView.layer.cornerRadius = 60
            avatarImageView.layer.masksToBounds = true
            
            isInitialized = true
        }
    }
}
