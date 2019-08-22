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
    var size:Int = 0
    var deviations:[Deviation] = [Deviation]()
    
    init() {
        
    }
    
    required init(json:JSON) {
        self.folderId = json["folderid"].string!
        self.name = json["name"].string!
        self.size = json["size"].int!
        
        self.deviations =  DeviantionHandler.filterJournalDeviation(deviants: JSONObjectHandler.convertToObjectArray(jsonArray: json["deviations"].arrayValue))
    }
}
