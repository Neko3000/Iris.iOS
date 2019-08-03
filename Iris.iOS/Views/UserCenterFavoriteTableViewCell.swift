//
//  UserCenterStatusTableViewCell.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 6/28/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class UserCenterFavoriteTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var leftContentImageView: UIImageView!
    
    @IBOutlet weak var rightContentImageView: UIImageView!
    
    private var tableViewWidth:CGFloat = 0
    
    private var isInitialized:Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            
            

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
    
    public func setContentImage(leftContentImage:UIImage,rightContentImage:UIImage,fullHeight:CGFloat,fullWidth:CGFloat,gapWidth:CGFloat){
        
        leftContentImageView.image = leftContentImage
        rightContentImageView.image = rightContentImage
        
        leftContentImageView.frame = CGRect(x: 0, y: 0, width: leftContentImage.size.width * fullHeight / leftContentImage.size.height , height: fullHeight)
        leftContentImageView.contentMode = .scaleToFill
        
        rightContentImageView.frame = CGRect(x: leftContentImageView.frame.width + gapWidth, y: 0, width: fullWidth - gapWidth - leftContentImageView.frame.width, height: fullHeight)
        rightContentImageView.contentMode = .scaleAspectFill
        
    }
}
