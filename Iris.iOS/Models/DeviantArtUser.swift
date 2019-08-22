//
//  DeviantArtUser.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/23/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation
import SwiftyJSON

class DeviantArtUser:ObjectFromJSON{
    
    var username:String = ""
    
    var userAvatarSrc:String = ""
    var userAvatarImage:UIImage?
    
    var bio:String = ""
    
    init() {
        
    }
    
    required init(json:JSON) {
        self.username = json["user"]["username"].string!
        self.userAvatarSrc = json["user"]["usericon"].string!
        
    }
}
