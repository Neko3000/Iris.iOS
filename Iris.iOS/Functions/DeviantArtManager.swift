//
//  DeviantArtManager.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/4/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation

class DeviantArtManager{
    
    // Login
    static let authorizationCodeURLEndPoint = "https://www.deviantart.com/oauth2/authorize"
    static let accessTokenURLEndPoint = "https://www.deviantart.com/oauth2/token"
    static let checkTokenURLEndPoint = "https://www.deviantart.com/api/v1/oauth2/placebo"
    static let refreshTokenURLEndPoint = "https://www.deviantart.com/oauth2/token"
    
    // Explore
    static let getPopularArtListURLEndPoint = "https://www.deviantart.com/api/v1/oauth2/browse/popular"
    static let getNewestArtListURLEndPoint = "https://www.deviantart.com/api/v1/oauth2/browse/newest"
    static let getUndiscoveredArtListURLEndPoint = "https://www.deviantart.com/api/v1/oauth2/browse/undiscovered"
    static let getArtMetaDataURLEndPoint = "https://www.deviantart.com/api/v1/oauth2/deviation/metadata"
    static let getArtCommentURLEndPoint = "https://www.deviantart.com/api/v1/oauth2/comments/deviation"
    
    // Daily
    static let getDailyDeviationURLEndPoint = "https://www.deviantart.com/api/v1/oauth2/browse/dailydeviations"
    
    // Activity
    static let getNotificationURLEndPoint = "https://www.deviantart.com/api/v1/oauth2/feed/notifications"
    
    // UserCenter
    static let getGalleryURLEndPoint = "https://www.deviantart.com/api/v1/oauth2/gallery/all"
    static let getJournalURLEndPoint = "https://www.deviantart.com/api/v1/oauth2/browse/user/journals"
    static let getStatusURLEndPoint = "https://www.deviantart.com/api/v1/oauth2/user/statuses"
    static let getCollectionFolderURLEndPoint = "https://www.deviantart.com/api/v1/oauth2/collections/folders"
    static let getCollectionURLEndPoint = "https://www.deviantart.com/api/v1/oauth2/collections"
    static let getWatcherURLEndPoint = "https://www.deviantart.com/api/v1/oauth2/user/watchers"
    static let getProfileCommentURLEndPoint = "https://www.deviantart.com/api/v1/oauth2/comments/profile"
    
    // Login
    static func generateAuthorizationCodeURL(responseType:String,clientId:String,redirectUrl:String,scope:String,state:String) -> URL{
        
        var urlComponents = URLComponents(string: authorizationCodeURLEndPoint)
        urlComponents?.queryItems = [
            URLQueryItem(name: "response_type", value: responseType),
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "redirect_uri", value: redirectUrl),
            URLQueryItem(name: "scope", value: scope),
            URLQueryItem(name: "state", value: state),
        ]
        
        return urlComponents!.url!
    }
    
    static func generateAccessTokenURL(clientId:String,clientSecret:String,grantType:String,code:String,redirectUrl:String)->URL{
        
        var urlComponents = URLComponents(string: accessTokenURLEndPoint)
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "client_secret", value: clientSecret),
            URLQueryItem(name: "grant_type", value: grantType),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: redirectUrl)
        ]
        
        return urlComponents!.url!
    }
    
    static func generateCheckTokenURL(accessToken:String) -> URL{
        var urlComponets = URLComponents(string: checkTokenURLEndPoint)
        urlComponets?.queryItems = [
            URLQueryItem(name:"access_token",value: accessToken)
        ]
        
        return urlComponets!.url!
    }
    
    static func generateRefreshTokenURL(clientId:String,clientSecret:String,grantType:String,refreshToken:String) -> URL{
        var urlComponents = URLComponents(string: refreshTokenURLEndPoint)
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "client_secret", value: clientSecret),
            URLQueryItem(name: "grant_type", value: grantType),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        
        return urlComponents!.url!
    }
    
    // Explore
    static func generateGetPopularArtListURL(categoryPath:String = "",q:String = "",timeRange:String = "",offset:Int? = nil,limit:Int? = nil,accessToken:String) -> URL{
        var urlComponents = URLComponents(string: getPopularArtListURLEndPoint)
        urlComponents?.queryItems = [
            URLQueryItem(name: "category_path", value: categoryPath),
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "timerange", value: timeRange),
            URLQueryItem(name: "offset", value: offset == nil ? "":String(offset!)),
            URLQueryItem(name: "limit", value: limit == nil ? "":String(limit!)),
            URLQueryItem(name: "access_token", value: accessToken)
        ]
        
        return urlComponents!.url!
    }
    
    static func generateGetNewestArtListURL(categoryPath:String = "",q:String = "",offset:Int? = nil,limit:Int? = nil,accessToken:String) -> URL{
        var urlComponents = URLComponents(string: getNewestArtListURLEndPoint)
        urlComponents?.queryItems = [
            URLQueryItem(name: "category_path", value: categoryPath),
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "offset", value: offset == nil ? "":String(offset!)),
            URLQueryItem(name: "limit", value: limit == nil ? "":String(limit!)),
            URLQueryItem(name: "access_token", value: accessToken)
        ]
        
        return urlComponents!.url!
    }
    
    static func generateGetUndiscoveredArtListURL(categoryPath:String = "",offset:Int? = nil,limit:Int? = nil,accessToken:String) -> URL{
        var urlComponents = URLComponents(string: getUndiscoveredArtListURLEndPoint)
        urlComponents?.queryItems = [
            URLQueryItem(name: "category_path", value: categoryPath),
            URLQueryItem(name: "offset", value: offset == nil ? "":String(offset!)),
            URLQueryItem(name: "limit", value: limit == nil ? "":String(limit!)),
            URLQueryItem(name: "access_token", value: accessToken)
        ]
        
        return urlComponents!.url!
    }
    
    static func generateGetArtMetaDataURL(deviationIds:String,extSubmission:String = "",extCamera:String = "",extStats:String = "",extCollection:String = "",accessToken:String) -> URL{
        var urlComponents = URLComponents(string: getArtMetaDataURLEndPoint)
        urlComponents?.queryItems = [
            URLQueryItem(name: "deviationids", value: deviationIds),
            URLQueryItem(name: "ext_submission", value: extSubmission),
            URLQueryItem(name: "ext_camera", value: extCamera),
            URLQueryItem(name: "ext_stats", value: extStats),
            URLQueryItem(name: "ext_collection", value: extCollection),
            URLQueryItem(name: "access_token", value: accessToken)
        ]
        
        return urlComponents!.url!
    }
    
    static func generateGetArtCommentURL(deviationId:String, commentId:String = "", maxDepth:String = "", offset:Int?, limit:Int?,accessToken:String) -> URL{
        var urlComponents = URLComponents(string: getArtCommentURLEndPoint + "/" + deviationId)
        urlComponents?.queryItems = [
            URLQueryItem(name: "commentid", value: commentId),
            URLQueryItem(name: "maxdepth", value: maxDepth),
            URLQueryItem(name: "offset", value: offset == nil ? "":String(offset!)),
            URLQueryItem(name: "limit", value: limit == nil ? "":String(limit!)),
            URLQueryItem(name: "access_token", value: accessToken)
        ]
        
        return urlComponents!.url!
    }
    
    // Daily
    static func generateGetDailyDeviationURL(date:String,accessToken:String) -> URL{
        var urlComponents = URLComponents(string: getDailyDeviationURLEndPoint)
        urlComponents?.queryItems = [
            URLQueryItem(name: "date", value: date),
            URLQueryItem(name: "access_token", value: accessToken)
        ]
        
        return urlComponents!.url!
    }
    
    // Activity
    static func generateGetNotificationURL(cursor:String = "",accessToken:String) -> URL{
        var urlComponents = URLComponents(string: getNotificationURLEndPoint)
        urlComponents?.queryItems = [
            URLQueryItem(name: "cursor", value: cursor),
            URLQueryItem(name: "access_token", value: accessToken)
        ]
        
        return urlComponents!.url!
    }
    
    // UserCenter
    static func generateGetGalleryURL(username:String = "",offset:Int? = nil,limit:Int? = nil,accessToken:String) -> URL{
        var urlComponents = URLComponents(string: getGalleryURLEndPoint)
        urlComponents?.queryItems = [
            URLQueryItem(name: "username", value: username),
            URLQueryItem(name: "offset", value: offset == nil ? "":String(offset!)),
            URLQueryItem(name: "limit", value: limit == nil ? "":String(limit!)),
            URLQueryItem(name: "access_token", value: accessToken)
        ]
        
        return urlComponents!.url!
    }
    
    static func generateGetJournalURL(username:String,featured:Bool = false,offset:Int? = nil, limit:Int? = nil,accessToken:String) -> URL{
        var urlComponents = URLComponents(string: getJournalURLEndPoint)
        urlComponents?.queryItems = [
            URLQueryItem(name: "username", value: username),
            URLQueryItem(name: "featured", value: String(featured)),
            URLQueryItem(name: "offset", value: offset == nil ? "":String(offset!)),
            URLQueryItem(name: "limit", value: limit == nil ? "":String(limit!)),
            URLQueryItem(name: "access_token", value: accessToken)
        ]
        
        return urlComponents!.url!
    }
    
    static func generateGetStatusURL(username:String,offset:Int? = nil, limit:Int? = nil,accessToken:String) -> URL{
        var urlComponents = URLComponents(string: getStatusURLEndPoint)
        urlComponents?.queryItems = [
            URLQueryItem(name: "username", value: username),
            URLQueryItem(name: "offset", value: offset == nil ? "":String(offset!)),
            URLQueryItem(name: "limit", value: limit == nil ? "":String(limit!)),
            URLQueryItem(name: "access_token", value: accessToken)
        ]
        
        return urlComponents!.url!
    }
    
    static func generateGetCollectionFolderURL(username:String, calculateSize:Bool = true, extPreload:Bool = true,offset:Int? = nil, limit:Int? = nil, accessToken:String) -> URL{
        var urlComponents = URLComponents(string: getCollectionFolderURLEndPoint)
        urlComponents?.queryItems = [
            URLQueryItem(name: "username", value: username),
            URLQueryItem(name: "calculate_size", value: String(calculateSize)),
            URLQueryItem(name: "ext_preload", value: String(extPreload)),
            URLQueryItem(name: "offset", value: offset == nil ? "":String(offset!)),
            URLQueryItem(name: "limit", value: limit == nil ? "":String(limit!)),
            URLQueryItem(name: "access_token", value: accessToken)
        ]
        
        return urlComponents!.url!
    }
    
    static func generateGetCollectionURL(folderId:String, username:String, offset:Int? = nil, limit:Int? = nil,accessToken:String) -> URL{
        var urlComponents = URLComponents(string: getCollectionURLEndPoint + "/" + folderId)
        urlComponents?.queryItems = [
            URLQueryItem(name: "username", value: username),
            URLQueryItem(name: "offset", value: offset == nil ? "":String(offset!)),
            URLQueryItem(name: "limit", value: limit == nil ? "":String(limit!)),
            URLQueryItem(name: "access_token", value: accessToken)
        ]
        
        return urlComponents!.url!
    }
    
    static func generateGetWatcherURL(username:String, offset:Int? = nil, limit:Int? = nil,accessToken:String) -> URL{
        var urlComponents = URLComponents(string: getWatcherURLEndPoint + "/" + username)
        urlComponents?.queryItems = [
            URLQueryItem(name: "offset", value: offset == nil ? "":String(offset!)),
            URLQueryItem(name: "limit", value: limit == nil ? "":String(limit!)),
            URLQueryItem(name: "access_token", value: accessToken)
        ]
        
        return urlComponents!.url!
    }
    
    static func generateGetProfileCommentURL(username:String, commentId:String = "", maxDeptch:Int? = nil, offset:Int? = nil, limit:Int? = nil,accessToken:String) -> URL{
        var urlComponents = URLComponents(string: getProfileCommentURLEndPoint + "/" + username)
        urlComponents?.queryItems = [
            URLQueryItem(name: "commentid", value: commentId),
            URLQueryItem(name: "maxdepth", value: maxDeptch == nil ? "":String(maxDeptch!)),
            URLQueryItem(name: "offset", value: offset == nil ? "":String(offset!)),
            URLQueryItem(name: "limit", value: limit == nil ? "":String(limit!)),
            URLQueryItem(name: "access_token", value: accessToken)
        ]
        
        return urlComponents!.url!
    }
}
