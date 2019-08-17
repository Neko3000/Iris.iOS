//
//  Deviation.swift
//  
//
//  Created by Xueliang Chen on 8/7/19.
//

import Foundation
import SwiftyJSON

class DeviationComment: ObjectFromJSON {
    
    public var deviationCommentId:String = ""
    public var parentDeviationCommentId:String = ""
    
    public var username:String = ""
    public var userAvatarSrc:String = ""
    public var userAvatarImage:UIImage?
    
    public var body:String = ""
    public var date:Date = Date()
    
    public var subDeviationComment:[DeviationComment]?
    
    init() {
        
    }
    
    required init(json:JSON) {
        
        self.deviationCommentId = json["commentid"].string!
        self.parentDeviationCommentId = json["parentid"].string ?? ""
        
        self.username = json["user"]["username"].string!
        self.userAvatarSrc = json["user"]["usericon"].string!
        
        self.body = json["body"].string!
        self.date = json["posted"].date!
    }
    
}
