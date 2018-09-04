//
//  RegisterViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2018/7/25.
//  Copyright © 2018年 czc. All rights reserved.
//

import Foundation


class RegisterViewModel: BaseViewModel {
    
  
    fileprivate var userInfo = UserInfo()
    
    //注册
    func register(password:String,mobile:String,verificationCode:String,finishedCallback : @escaping () -> ()){
        let param=NSMutableDictionary()
        param.setValue(password.sha1(), forKey: "password")
        param.setValue(mobile, forKey: "mobile")
        param.setValue(verificationCode, forKey: "verificationCode")
        self.loadData(action: Api.USER_REGISTER, param: param) { (jsonString) in
            
            //完成回调
           finishedCallback()
           Utils.showHUD(info: "注册成功")
        
           UserSettings.shareInstance.setValue(key: UserSettings.USER_PHONE, value:mobile)
           UserSettings.shareInstance.setValue(key: UserSettings.USER_PASSWORD, value:password)
            
        }
        
    }
    
    //发送验证码
    func sendCode(phone:String,finishCallback: @escaping() ->()) {
        
        let param=NSMutableDictionary()
        param.setValue(phone, forKey: "mobile")
        loadData(action: Api.USER_SEND_CODE, param: param) { (jStr) in
            
            
            finishCallback()
            Utils.showHUD(info:"验证码已发送")
        }
        
    }
    
    
    //登录
    func login(phone:String,pwd:String,finishCallBack: @escaping() ->()){
        
        let param=NSMutableDictionary()
        param.setValue(phone, forKey: "mobile")
        param.setValue(pwd.sha1(), forKey: "password")
        loadData(action: Api.USER_LOGIN, param: param) { (jStr) in
           
            
            
            if let result = CommonResult<UserInfo>(JSONString:jStr){
                
            
                
                print(result.resultData.mobile)
                
                 Utils.showHUD(info: "登录成功")
                 UserSettings.shareInstance.setValue(key: UserSettings.IS_LOGIN, value: true)
                 UserSettings.shareInstance.setValue(key: UserSettings.TOKEN, value:result.resultData.token)
                 UserSettings.shareInstance.setValue(key: UserSettings.USER_PASSWORD, value:pwd)
                 UserSettings.shareInstance.setValue(key: UserSettings.USER_ID, value:result.resultData.userId)
                UserSettings.shareInstance.setValue(key: UserSettings.USER_PHONE, value:result.resultData.mobile)
                if let registerID =  result.resultData.currentDeviceId {
                    
                      UserSettings.shareInstance.setValue(key: UserSettings.DEVICE_ID, value:registerID)
                }
                if let nickname = result.resultData.nickname{
                    
                    UserSettings.shareInstance.setValue(key: UserSettings.USER_NICK_NAME, value:nickname)
                }
                if let avatar = result.resultData.avatar{
                    
                    UserSettings.shareInstance.setValue(key: UserSettings.USER_PHOTO, value:avatar)
                }
                
                
                
                finishCallBack()
            }
            
        }
    }
    
    
    //验证码登录
    
    
    func codeLogin(phone:String,code:String,finishCallback:@escaping() ->()){
        
        let param=NSMutableDictionary()
        param.setValue(phone, forKey: "mobile")
        param.setValue(code, forKey: "verificationCode")
        
        loadData(action: Api.USER_CODE_LOGIN, param: param) { (jStr) in
            
            
            if let result = CommonResult<UserInfo>(JSONString:jStr){
                
               
                Utils.showHUD(info: "登录成功")
                UserSettings.shareInstance.setValue(key: UserSettings.TOKEN, value:result.resultData.token)
                UserSettings.shareInstance.setValue(key: UserSettings.USER_ID, value:result.resultData.userId)
                UserSettings.shareInstance.setValue(key: UserSettings.USER_PHONE, value:result.resultData.mobile)
                if let registerID =  result.resultData.currentDeviceId {
                    UserSettings.shareInstance.setValue(key: UserSettings.DEVICE_ID, value:registerID)
                }
                if let nickname = result.resultData.nickname{
                    
                    UserSettings.shareInstance.setValue(key: UserSettings.USER_NICK_NAME, value:nickname)
                }
                if let avatar = result.resultData.avatar{
                    
                    UserSettings.shareInstance.setValue(key: UserSettings.USER_PHOTO, value:avatar)
                }
                
                //完成回调
                finishCallback()
            }
        }
    }
    
    
    // 重置密码
    
    func resetPassword(password:String,mobile:String,verificationCode:String,finishedCallback : @escaping () -> ()){
        let param=NSMutableDictionary()
        param.setValue(password.sha1(), forKey: "newPassword")
        param.setValue(mobile, forKey: "mobile")
        param.setValue(verificationCode, forKey: "verificationCode")
        self.loadData(action: Api.USER_RESET_PASSWORD, param: param) { (jsonString) in
            
            //完成回调
            finishedCallback()
            Utils.showHUD(info: "密码已重置")
        }
        
    }

    //修改密码
    func updatePassword(password:String,newPassword:String,finishedCallback : @escaping () -> ()){
        let param=NSMutableDictionary()
        param.setValue(password.sha1(), forKey: "password")
        param.setValue(newPassword.sha1(), forKey: "newPassword")
   
        self.loadData(action: Api.USER_UPDATE_PASSWORD, param: param) { (jsonString) in
            
            //完成回调
            finishedCallback()
            Utils.showHUD(info: "密码已修改")
        }
        
    }
    
    
    //修改密码
    func updateMasterPassword(masterPassword:String,deviceId:String,mobile:String,verificationCode:String,finishedCallback : @escaping () -> ()){
        
        let param=NSMutableDictionary()
        param.setValue(masterPassword, forKey: "masterPassword")
        param.setValue(deviceId, forKey: "deviceId")
        param.setValue(mobile, forKey: "mobile")
        param.setValue(verificationCode, forKey: "verificationCode")
        
        self.loadData(action: Api.DEVICE_UPDATE_MASTERPWD, param: param) { (jsonString) in
            
            //完成回调
            finishedCallback()
            Utils.showHUD(info: "管理员密码已修改")
        }
        
    }
    
    

}
