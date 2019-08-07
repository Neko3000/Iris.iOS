//
//  ObjectDictionartProtocols.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 12/4/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

protocol ObjectFromDictionary {
    init(dict:[String:Any])
}

protocol ObjectToDictionary {
    func toDictionary() -> [String:Any]
}
