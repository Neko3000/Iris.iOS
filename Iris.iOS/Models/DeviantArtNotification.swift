//
//  DeviantArtNotification.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/19/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation
import SwiftyJSON

class DeviantArtNotification: ObjectFromJSON {
    
    public var date:Date = Date()
    
    public var deviationTitle:String = ""
    public var deviationContentSrc:String = ""
    public var deviationContentImage:UIImage?
    
    public var username:String = ""
    public var userAvatarSrc:String = ""
    public var userAvatarImage:UIImage?
    
    public var commentBody:String = ""
    
    public var notificationType:DeviationArtNotificationType = .none
    public var notificationTypeString:String{
        get{
            var type = ""
            switch notificationType {
            case .replay:
                type = "replied"
                break
            case .commentDeviation:
                type = "commented in deivation"
                break
            case .commentProfile:
                type = "commented in profile"
                break
            case .mentionDeviationInDeviation:
                type = "mentioned devitaion in deviation "
                break
            case .mentionUserInDeviation:
                type = "mentioned user in deviation "
                break
            case .mentionDeviationInComment:
                type = "mentioned deviation in comment"
                break
            case .mentionUserInComment:
                type = "mentioned user in comment"
                break
            case .mentionDeviationInStatus:
                type = "mentioned deviation in status"
                break
            case .watch:
                type = "watched"
                break
            case .favourite:
                type = "favourited"
                break
            default:
                break
            }
            
            return type
        }
    }
    
    init() {
        
    }
    
    required init(json:JSON) {
        
        self.date = json["ts"].date!
        
        self.deviationTitle = json["deviations"] == JSON.null ? "":json["deviations"].arrayValue.first!["title"].string!
        self.deviationContentSrc = json["deviations"] == JSON.null ? "":json["deviations"].arrayValue.first!["content"]["src"].string!
        
        self.username = json["by_user"]["username"].string!
        self.userAvatarSrc = json["by_user"]["usericon"].string!
        
        self.commentBody = json["comment"] == JSON.null ? "":json["comment"]["body"].string!
        
        self.notificationType = DeviationArtNotificationType(rawValue: json["type"].string!)!
    }
    
}

