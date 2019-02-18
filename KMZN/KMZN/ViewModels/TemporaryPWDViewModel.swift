//
//  TemporaryPWDViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2018/10/15.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class TemporaryPWDViewModel: BaseViewModel {
    
    
    var recordList = [TemporaryPwdInfo]()
    
    func addTemporaryOncePassword(name:String?,deviceId:String,masterPassword:String,password:String,finishedCallback : @escaping () -> ()){
        
        let param = NSMutableDictionary()
        
        param.setValue(name, forKey: "name")
        param.setValue(deviceId, forKey: "deviceId")
        param.setValue(masterPassword, forKey: "masterPassword")
        param.setValue(password, forKey: "password")
        
         Utils.showStatus(info: "加载中...")
        
        
        loadData(action: Api.TEMPORARY_ONCE_PWD, param: param) { (jsonStr) in
            
           
            finishedCallback()
            
            Utils.showHUD(info: "命令下发成功")
        }
    }
    
    
    
    func addTemporaryRepeatPassword(deviceId:String,masterPassword:String,password:String,beginTime:String,endTime:String,repeatWeek:String,name:String?,finishedCallback : @escaping () -> ()){
        
        let param = NSMutableDictionary()
        let pwdBeaginTime = beginTime + ":00"
        let pwdEndTime = endTime + ":00"
        param.setValue(deviceId, forKey: "deviceId")
        param.setValue(masterPassword, forKey: "masterPassword")
        param.setValue(password, forKey: "password")
        param.setValue(pwdBeaginTime, forKey: "passwordBeginTime")
        param.setValue(pwdEndTime, forKey: "passwordEndTime")
        param.setValue(repeatWeek, forKey: "repeatWeek")
        param.setValue(name, forKey: "name")
        
         Utils.showStatus(info: "加载中...")
        
        loadData(action: Api.TEMPORARY_REPEAT_PWD, param: param) { (jsonStr) in
            
            
            finishedCallback()
            Utils.showHUD(info: "命令下发成功")
        }
    }
    
    
    func getTemporaryPasswordList(deviceId:String,temporaryType:String?,finishedCallback : @escaping () -> ()){
        
        let param = NSMutableDictionary()
        
        param.setValue(deviceId, forKey: "deviceId")
        
        if temporaryType != nil{
            
            param.setValue(temporaryType, forKey: "temporaryType")
        }
        
        loadData(action: Api.TEMPORARY_LIST_PWD, param: param) { (jsonStr) in
            
            if let result = CommonResult<PageRow<TemporaryPwdInfo>>(JSONString: jsonStr){
                
                self.recordList = result.resultData.list
                
                
                
                finishedCallback()
            }
            
        }
    }
    

}
