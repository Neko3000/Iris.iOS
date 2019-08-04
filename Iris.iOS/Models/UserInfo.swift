//
//  UserState.swift
//  ActivityReceiver.iOS
//
//  Created by Xueliang Chen on 10/26/18.
//  Copyright © 2018 Conceptual. All rights reserved.
//

import Foundation

class UserInfo: NSObject,NSCoding {
    
    var username:String
    var token:String
    
    init(username:String,token:String) {
        self.username = username
        self.token = token
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let username = aDecoder.decodeObject(forKey: "username") as! String
        let token = aDecoder.decodeObject(forKey: "token") as! String
        
        self.init(username: username, token: token)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: "username")
        aCoder.encode(token, forKey: "token")
    }
    
    func getUsername() -> String{
        return username
    }
    
    func getToken() -> String {
        return token
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
        
        userDefaults.removeObject(forKey: "CurrentUserInfo")
    }
}
