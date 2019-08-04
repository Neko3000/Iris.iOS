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
    private static var token:String = ""
    
    public static func getUsername()->String{
        return username
    }
    
    public static func setUsername(username:String){
        self.username = username
    }
    
    public static func getToken()->String{
        return token
    }
    
    public static func setToken(token:String){
        self.token = token
    }
    
    public static func clear(){
        
        username = ""
        token = ""
    }
}
