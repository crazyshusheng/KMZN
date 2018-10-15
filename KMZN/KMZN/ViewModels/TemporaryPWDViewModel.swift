//
//  TemporaryPWDViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2018/10/15.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class TemporaryPWDViewModel: BaseViewModel {
    
    
    func addTemporaryOncePassword(deviceId:String,masterPassword:String,password:String,finishedCallback : @escaping () -> ()){
        
        let param = NSMutableDictionary()
        
        param.setValue(deviceId, forKey: "deviceId")
        param.setValue(masterPassword, forKey: "masterPassword")
        param.setValue(password, forKey: "password")
        
        loadData(action: Api.TEMPORARY_ONCE_PWD, param: param) { (jsonStr) in
            
           
            
        }
    }
    
    
    
    func addTemporaryRepeatPassword(deviceId:String,masterPassword:String,password:String,beginTime:String,endTime:String,repeatWeek:String,name:String,finishedCallback : @escaping () -> ()){
        
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
        
        loadData(action: Api.TEMMPORARY_REPEAT_PWD, param: param) { (jsonStr) in
            
            
            
        }
    }
    
    

}
