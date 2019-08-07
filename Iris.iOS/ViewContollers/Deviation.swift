//
//  Deviation.swift
//  
//
//  Created by Xueliang Chen on 8/7/19.
//

import Foundation

class Deviation: ObjectFromDictionary {
    
    public var deviationId:String = ""
    public var title:String = ""
    public var description:String = "" // exist?
    public var category:String = ""
    public var categoryPath:String = ""
    public var isFavourited:Bool = false
    
    public var previewSrc:String = ""
    public var contentSrc:String = ""
    
    public var isDownloadable:Bool = false
    
    public var userName:String = ""
    public var userAvatar:String = ""
    
    init() {
        
    }
    
    required init(dict: [String : Any]) {
        self.deviationId = dict["deviationid"] as! String
        self.title = dict["title"] as! String
        self.category = dict["category"] as! String
        self.category = dict["category_path"] as! String
        self.isFavourited = dict["is_favourited"] as! Bool
        self.previewSrc = dict["preview"]!["src"] as! String
        self.deviationId = dict["deviationid"] as! String
        self.deviationId = dict["deviationid"] as! String
        self.deviationId = dict["deviationid"] as! String
        self.deviationId = dict["deviationid"] as! String
        
    }
}
