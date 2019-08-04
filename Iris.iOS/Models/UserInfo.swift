//
//  UserInfo.swift
//  Iris.iOS
//
//  Created by Xueliang Chen on 8/4/19.
//  Copyright © 2019 Conceptual. All rights reserved.
//

import Foundation

class UserInfo: NSObject,NSCoding {
    
    var username:String
    var accessToken:String
    var refreshToken:String
    
    init(username:String,accessToken:String,refreshToken:String = "") {
        self.username = username
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let username = aDecoder.decodeObject(forKey: "username") as! String
        let accessToken = aDecoder.decodeObject(forKey: "accessToken") as! String
        let refreshToken = aDecoder.decodeObject(forKey: "refreshToken") as! String

        
        self.init(username: username, accessToken: accessToken, refreshToken:refreshToken)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: "username")
        aCoder.encode(accessToken, forKey: "accessToken")
        aCoder.encode(refreshToken, forKey: "refreshToken")
    }
    
    func getUsername() -> String{
        return username
    }
    
    func getAccessToken() -> String {
        return accessToken
    }
    
    func getRefreshToken() -> String {
        return refreshToken
    }
    
    static func saveUserInfo(userInfoObject:UserInfo){
        
        // Bundle
        let userDefaults = UserDefaults.standard
        
        // Save UserInfo
        let codedMyUserInfo:Data = NSKeyedArchiver.archivedData(withRootObject: userInfoObject)
        userDefaults.set(codedMyUserInfo,forKey:"CurrentUserInfo")
        
        userDefaults.synchronize()
    }
    
    static func loadUserInfo() -> UserInfo?{
        
        // Bundle
        let userDefaults = UserDefaults.standard
        
        // Load UserInfo
        if let originalObject = userDefaults.object(forKey: "CurrentUserInfo"){
            let decodedData = originalObject as! Data
            let userInfo = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! UserInfo
            
            return userInfo
        }
        
        return nil
    }
    
    static func clearStoredUserInfo(){
        
        // Bundle
        let userDefaults = UserDefaults.standard
        
        // Remove UserInfo
        userDefaults.removeObject(forKey: "CurrentUserInfo")
    }
}
