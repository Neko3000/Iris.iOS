//
//  UserCenterStatusTableViewCell.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 6/28/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class UserCenterFollowerTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var addBtn: UIButton!
    
    private var isInitialized:Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            avatarImageView.layer.cornerRadius = 8.0
            avatarImageView.layer.masksToBounds = true
            
            addBtn.layer.applySketchShadow(color: UIColor(named: "shadow-normal-pink")!, alpha: 1.0, x: 0, y: 8.0, blur: 12.0, spread: 0)

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
