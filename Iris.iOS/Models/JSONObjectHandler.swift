//
//  JSONObjectHandler.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/7/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONObjectHandler{
    static func convertToObjectArray<T:ObjectFromJSON>(jsonArray:[JSON])->[T]{
        
        var objectArray = [T]()
        for i in 0..<jsonArray.count{
            objectArray.append(T.init(json: jsonArray[i]))
        }
        return objectArray
    }
}
