//
//  AlamofireManager.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 8/4/19.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireManager{
    
    // Update - SessionManager has been renamed to Session in Alamofire 5.0
    static let sharedSession: Alamofire.Session = {
        
        let configuration = URLSessionConfiguration.default
        
        // Timeout in 180s
        configuration.timeoutIntervalForRequest = 180
        
        return Alamofire.Session(configuration: configuration)
    }()
    
}
