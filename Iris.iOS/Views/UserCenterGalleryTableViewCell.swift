//
//  UserCenterGalleryTableViewCell.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/29/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class UserCenterGalleryTableViewCell: UITableViewCell {

    @IBOutlet weak var artImageView: UIImageView!
    
    private var isInitialized:Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            artImageView.layer.cornerRadius = 8.0
            artImageView.layer.masksToBounds = true
            
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
