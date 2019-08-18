//
//  ActivityCollectionViewCell.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/21/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class ActivityTableViewNormalCell: UITableViewCell {

    @IBOutlet weak var deviationTitleLabel: UILabel!
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var notificationTypeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundContainerView: UIView!
    
    var isInitialized:Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            userAvatarImageView.layer.cornerRadius = 15.0
            userAvatarImageView.layer.masksToBounds = true
            
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
