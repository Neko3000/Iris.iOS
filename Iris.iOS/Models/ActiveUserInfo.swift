//
//  CurrentUserInfo.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 11/6/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

class ActiveUserInfo{
    
    // Single-Skeleton for UserInfo
    
    private static var username:String = ""
    private static var accessToken:String = ""
    private static var refreshToken:String = ""
    
    // Setter/Getter
    public static func getUsername()->String{
        return username
    }
    
    public static func setUsername(username:String){
        self.username = username
    }
    
    public static func getAccesssToken()->String{
        return accessToken
    }
    
    public static func setAcesssToken(accessToken:String){
        self.accessToken = accessToken
    }
    
    public static func getRefreshToken()->String{
        return refreshToken
    }
    
    public static func setRefreshToken(refreshToken:String){
        self.refreshToken = refreshToken
    }
    
    public static func clear(){
        
        username = ""
        accessToken = ""
        refreshToken = ""
    }
}
