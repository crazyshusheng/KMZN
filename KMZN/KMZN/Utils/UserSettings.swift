//
//  UserSettings.swift
//  KMZN
//
//  Created by 陈志超 on 2018/7/25.
//  Copyright © 2018年 czc. All rights reserved.
//

import Foundation



class UserSettings{
    
    static let shareInstance = UserSettings()
    
    var userDefaults:UserDefaults!
    
    static let IS_LOGIN = "is_login" //是否登录
    static let TOKEN = "token"
    static let USER_ID = "userId" //用户id String类型
    static let USER_PHONE = "phone" //用户姓名
    static let USER_PASSWORD = "user_password" //用户密码
    static let USER_PHOTO = "user_photo"
    static let USER_NICK_NAME = "user_nickname"
    
    static let DEVICE_ID = "deviceId"
    static let DEVICE_IMEI = "imei"
    static let DEVICE_IMSI = "imsi"
    
    
    static let VERSION = "appVersion" //版本号
    static let USER_THIRDTYPE = "thirdPartyType"
    static let USER_THIRDID = "thirdPartyId"
    

    private init(){
        
        userDefaults = UserDefaults.standard
       
    }
    
    
    func setValue(key:String,value:Any){
    
        userDefaults.set(value, forKey: key)
    }
    
    
    func getStringValue(key:String)->String?{
        
        return  userDefaults.value(forKey: key) as? String
    }
    
    func getUserID() ->Int?{
        
        return userDefaults.value(forKey: UserSettings.USER_ID) as? Int
    }
    
    
    
    //判断用户是否登录
    func isLogin()->Bool{
        return userDefaults.bool(forKey: UserSettings.IS_LOGIN)
    }

    
   
    func clearUserInfo(){
        
        let array = [UserSettings.TOKEN,UserSettings.DEVICE_ID,UserSettings.USER_PHOTO,UserSettings.USER_NICK_NAME]
      
        for key in array {
            
            userDefaults.removeObject(forKey: key)
        }
    
       userDefaults.setValue(false, forKey: UserSettings.IS_LOGIN)
    
        JPUSHService.deleteAlias(nil, seq: 0)
            
    
       
    }
    
 
    
}

