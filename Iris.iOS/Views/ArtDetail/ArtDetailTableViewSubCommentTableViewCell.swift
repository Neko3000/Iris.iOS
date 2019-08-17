//
//  ArtDetailCommentTableViewTableViewCell.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/25/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class ArtDetailTableViewSubCommentTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    
    
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    
    @IBOutlet weak var dialogBackgroundView: UIView!
    
    var isInitialized:Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            userAvatarImageView.layer.cornerRadius = 15.0
            userAvatarImageView.layer.masksToBounds = true
            
            dialogBackgroundView.layer.cornerRadius = 8.0
            dialogBackgroundView.layer.masksToBounds = true
            
            isInitialized = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
