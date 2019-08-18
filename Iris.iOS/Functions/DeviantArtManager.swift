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
}
