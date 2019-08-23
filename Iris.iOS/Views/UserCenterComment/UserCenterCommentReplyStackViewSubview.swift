
//
//  UserCenterCommentHeaderStackViewSubview.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 7/29/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class UserCenterCommentReplyStackViewSubview: XibUIView {

    @IBOutlet weak var bodyLabel: UILabel!

    @IBOutlet weak var authorAvatarImageView: UIImageView!
    @IBOutlet weak var authorNameDateLabel: UILabel!
    
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
            authorAvatarImageView.layer.cornerRadius = 13.0
            authorAvatarImageView.layer.masksToBounds = true

            isInitialized = true
        }
    }
    
    
}
