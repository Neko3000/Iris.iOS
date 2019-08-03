//
//  ActivityCollectionViewCell.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/21/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class ActivityTableViewSubmitCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundContainerView: UIView!
    
    var isInitialized:Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            avatarImageView.layer.cornerRadius = 15.0
            avatarImageView.layer.masksToBounds = true
            
            backgroundContainerView.layer.cornerRadius = 8.0
            backgroundContainerView.layer.masksToBounds = true
            
            isInitialized = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
