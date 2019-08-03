//
//  UserCenterJournalsTableViewCell.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 6/28/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class UserCenterCommentHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var editorAvatarImageView: UIImageView!
    
    private var isInitialized:Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            editorAvatarImageView.layer.cornerRadius = 13.0
            editorAvatarImageView.layer.masksToBounds = true
            
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
