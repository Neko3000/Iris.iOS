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
}
