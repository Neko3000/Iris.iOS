//
//  RequestAnalyzer.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/4/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation

class RequestAnalyzer{
    
    static func getQueryStringParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
}
