//
//  DailyTableViewDateTableViewCell.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/18/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import UIKit

class DailyTableViewDateTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    
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
}
