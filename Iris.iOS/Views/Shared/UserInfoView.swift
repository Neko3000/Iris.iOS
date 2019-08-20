//
//  UserInfoView.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/28/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

@IBDesignable
class UserInfoView: XibUIView {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    
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
            
            moreBtn.removeFromSuperview()
            
            isInitialized = true
        }
    }
}
