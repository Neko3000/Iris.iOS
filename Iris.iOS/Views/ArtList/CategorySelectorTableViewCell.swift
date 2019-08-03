//
//  ArtListCategoryTableViewCell.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 5/20/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class CategorySelectorTableViewCell: UITableViewCell {
    
    var selectionState:Bool = false

    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    var isInitialized:Bool = false
    
    override func layoutSubviews() {
        if(!isInitialized){
            self.selectionStyle = .none
            
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
        selectionState = selected
        setStateImageView(isSelected: selected)

    }
    
    public func setStateImageView(isSelected:Bool){
        stateImageView.image = isSelected ? UIImage(named: "icon-dot-active"):UIImage(named: "icon-dot")
    }
    public func setCategoryNameLabel(categoryName:String){
        categoryNameLabel.text = categoryName
    }
}
