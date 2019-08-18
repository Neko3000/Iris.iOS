//
//  DailyDeviation.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/18/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation

class DailyDeviation{
    var date:Date = Date()
    var deviations:[Deviation] = [Deviation]()
    
    init(){
        
    }
    
    init(date:Date,deviations:[Deviation]) {
        self.date = date
        self.deviations = deviations
    }
}
