//
//  DailyTableViewCell.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/14/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class DailyTableViewPostTableViewCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var authorAvatarImageView: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    
    private var isInitialized:Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            authorAvatarImageView.layer.cornerRadius = 17
            authorAvatarImageView.layer.masksToBounds = true
            
            selectionStyle = .none
            
            isInitialized = true
        }
    }
    
    // Sets
    public func setArt(art:UIImage){
        artImageView.image = art
    }
    public func setTitle(title:String){
        titleLabel.text = title
    }
    public func setCommentCount(commentCount:String){
        commentCountLabel.text = commentCount
    }
    public func setLikeCount(likeCount:String){
        likeCountLabel.text = likeCount
    }
    public func setAuthorName(authorName:String){
        authorNameLabel.text = authorName
    }
    public func setAuthorAvatar(authorAvatar:UIImage){
        authorAvatarImageView.image = authorAvatar
    }
}
