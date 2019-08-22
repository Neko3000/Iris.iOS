//
//  StatusCollection.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/22/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation
import UIKit

class StatusForSingleMonth{
    var date:Date = Date()
    var statuses:[Status] = [Status]()

    init(){
        
    }
    
    init(date:Date,statuses:[Status]) {
        self.date = date
        self.statuses = statuses
    }
}
