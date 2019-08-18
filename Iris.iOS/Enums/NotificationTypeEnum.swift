//
//  NotificationTypeEnum.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/19/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation

enum DeviationArtNotificationType:String{
    case none = ""
    case replay = "reply"
    case commentDeviation = "comment_deviation"
    case commentProfile = "comment_profile"
    case mentionDeviationInDeviation = "mention_deviation_in_deviation"
    case mentionUserInDeviation = "mention_user_in_deviation"
    case mentionDeviationInComment = "mention_deviation_in_comment"
    case mentionUserInComment = "mention_user_in_comment"
    case mentionDeviationInStatus = "mention_deviation_in_status"
    case mentionUserInStatus = "mention_user_in_status"
    case watch = "watch"
    case favourite = "favourite"
}
