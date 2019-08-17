//
//  JSONDateExtension.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/17/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation
import SwiftyJSON

extension JSON {
    public var date: Date? {
        get {
            if let str = self.string {
                return JSON.jsonDateFormatter.date(from: str)
            }
            return nil
        }
    }
    
    private static let jsonDateFormatter: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        return fmt
    }()
}
