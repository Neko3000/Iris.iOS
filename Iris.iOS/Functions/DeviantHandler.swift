//
//  DeviantHandler.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/13/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation

class DeviantHandler{
    static func filterJournalDeviant(deviants:[Deviation])->[Deviation]{
        var filteredDeviations = [Deviation]()
        
        for i in 0..<deviants.count{
            let deviant = deviants[i]
            
            if(deviant.category.lowercased().contains("journal") || deviant.categoryPath.lowercased().contains("journal")){
                continue
            }
            
            if(deviant.previewSrc == "" || deviant.contentSrc == ""){
                continue
            }
            
            filteredDeviations.append(deviant)
        }
        
        return filteredDeviations
    }
}
