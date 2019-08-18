//
//  Deviation.swift
//  
//
//  Created by Xueliang Chen on 8/7/19.
//

import Foundation
import SwiftyJSON

class Deviation: ObjectFromJSON {
    
    public var deviationId:String = ""
    public var title:String = ""
    public var category:String = ""
    public var categoryPath:String = ""
    public var isFavourited:Bool = false
    
    public var previewSrc:String = ""
    public var previewImage:UIImage?
    public var contentSrc:String = ""
    public var contentImage:UIImage?
    
    public var isDownloadable:Bool = false
    
    public var authorName:String = ""
    public var authorAvatarSrc:String = ""
    public var authorAvatarImage:UIImage?
    
    public var commentCount:Int = 0
    public var favouriteCount:Int = 0
    
    init() {
        
    }
    
    required init(json:JSON) {
        
        self.deviationId = json["deviationid"].string!
        self.title = json["title"].string!
        self.category = json["category"].string!
        self.categoryPath = json["category_path"].string!
        self.isFavourited = json["is_favourited"].bool!
        self.previewSrc = json["preview"]["src"].string ?? ""
        self.contentSrc = json["content"]["src"].string ?? ""
        self.isDownloadable = json["is_downloadable"].bool!
        self.authorName = json["author"]["username"].string!
        self.authorAvatarSrc = json["author"]["usericon"].string!
        self.commentCount =  json["stats"]["comments"].int!
        self.favouriteCount = json["stats"]["favourites"].int!
    }
    
}
