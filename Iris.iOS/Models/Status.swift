//
//  Status.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/22/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation
import SwiftyJSON

class Status: ObjectFromJSON {
    
    public var date:Date = Date()
    public var body:String = ""
    
    var authorAvatarSrc:String = ""
    var authorAvatarImage:UIImage?
    
    init() {
        
    }
    
    required init(json:JSON) {
        
        self.date = json["ts"].date!
        self.body = json["body"].string!
        
        self.authorAvatarSrc = json["author"]["usericon"].string!
    }
    
}
