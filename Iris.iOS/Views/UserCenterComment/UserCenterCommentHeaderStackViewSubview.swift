
//
//  UserCenterCommentHeaderStackViewSubview.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 7/29/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class UserCenterCommentHeaderStackViewSubview: XibUIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var isInitialized:Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            avatarImageView.layer.cornerRadius = 13.0
            avatarImageView.layer.masksToBounds = true

            isInitialized = true
        }
    }
    
    
}
