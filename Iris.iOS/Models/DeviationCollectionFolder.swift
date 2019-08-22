//
//  CollectionFolder.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/22/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation
import SwiftyJSON

class DeviationCollectionFolder:ObjectFromJSON{
    
    var folderId:String = ""
    var name:String = ""
    var size:String = ""
    var deviations:[Deviation]?
    
    init() {
        
    }
    
    required init(json:JSON) {
        self.folderId = json["folderid"].string!
        self.name = json["name"].string!
        self.size = json["size"].string!
        self.deviations =  JSONObjectHandler.convertToObjectArray(jsonArray: json["deviations"].arrayValue)
    }
}
