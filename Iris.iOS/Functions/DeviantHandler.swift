//
//  DeviantHandler.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/13/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation

class DeviantionHandler{
    static func filterJournalDeviation(deviants:[Deviation])->[Deviation]{
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
    
    static func formatCategoryPath(categoryPath:String)->String{
        
        var categorySections:[String.SubSequence] = categoryPath.split(separator: "/")
        var convertedCategorySections:[String] = [String]()
        
        for i in 0..<categorySections.count{
            convertedCategorySections.append(String(categorySections[i].capitalized))
        }
        
        return convertedCategorySections.joined(separator: " / ")
    }
    
    static func formateDate(date:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY"
        
        return dateFormatter.string(from: date)
    }
    
    // DeviationComment and DeviationSubComment
    static func organizeDeviationComments(deviationComments:[DeviationComment])->[DeviationComment]{
        
        // Organzie
        var sortedDeviationComments = deviationComments.sorted(by: {$0.date > $1.date})
        for i in 0..<sortedDeviationComments.count{
            let deviationComment = sortedDeviationComments[i]
            
            if(deviationComment.parentDeviationCommentId != ""){
                
                var parentDeviationComment:DeviationComment? = nil
                while(true){
                    parentDeviationComment = sortedDeviationComments.first(where: {dc in dc.deviationCommentId == deviationComment.parentDeviationCommentId})
                    
                    if(parentDeviationComment?.parentDeviationCommentId == "" || parentDeviationComment == nil){
                        break
                    }
                }
                
                // ParentDeviationComment is not exist
                if(parentDeviationComment == nil){
                    deviationComment.parentDeviationCommentId = ""
                }
                else{
                    if(parentDeviationComment!.subDeviationComment == nil){
                        parentDeviationComment!.subDeviationComment = [DeviationComment]()
                    }
                    
                    parentDeviationComment!.subDeviationComment!.append(deviationComment)
                }
                
            }
            else{
                deviationComment.subDeviationComment = [DeviationComment]()
            }
            
        }
        
        // Append roots
        var organziedDeviationComments:[DeviationComment] = [DeviationComment]()
        for i in 0..<sortedDeviationComments.count{
            let deviationComment = sortedDeviationComments[i]
            
            if(deviationComment.parentDeviationCommentId == ""){
                organziedDeviationComments.append(deviationComment)
            }
        }
        
        return organziedDeviationComments
    }
    
    static func getOrganizedDeviationCommentsCount(deviationComments:[DeviationComment])->Int{
        
        var count = 0
        
        for i in 0..<deviationComments.count{
            let deviationComment = deviationComments[i]
            
            count += 1
            
            if deviationComment.subDeviationComment != nil{
                count += deviationComment.subDeviationComment!.count
            }
        }
        
        return count
    }
}
