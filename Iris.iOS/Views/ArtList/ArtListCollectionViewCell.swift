//
//  ArtListCollectionViewCell.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/18/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class ArtListCollectionViewCell: UICollectionViewCell {
    
    // Outlets
    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    
    var isInitialized:Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if(!isInitialized){
            artImageView.layer.cornerRadius = 8.0
            artImageView.layer.masksToBounds = true
            
            isInitialized = true
        }
    }

    // Sets
    public func setArt(art:UIImage){
        artImageView.image = art
    }
    public func setAuthorName(authorName:String){
        authorNameLabel.text = authorName
    }
}
