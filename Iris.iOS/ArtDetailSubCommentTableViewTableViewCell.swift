//
//  ArtDetailCommentTableViewTableViewCell.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/25/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class ArtDetailSubCommentTableViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var dialogBackgroundView: UIView!
    
    var isInitialized:Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            avatarImageView.layer.cornerRadius = 15.0
            avatarImageView.layer.masksToBounds = true
            
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
