//
//  DeviantArtManager.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/4/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation

class DeviantArtManager{
    static let authorizationCodeURLEndPoint = "https://www.deviantart.com/oauth2/authorize"
    static let accessTokenURLEndPoint = "https://www.deviantart.com/oauth2/token"
    static let checkTokenURLEndPoint = "https://www.deviantart.com/api/v1/oauth2/placebo"
    static let refreshTokenURLEndPoint = "https://www.deviantart.com/oauth2/token"
    
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
}
