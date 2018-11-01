//
//  AddPwdViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/21.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class AddPwdViewModel: BaseViewModel {
    
    
    
    func addDevicePwd(deviceId:String,name:String,password:String,finishCallback: @escaping() ->()) {
        
        let param = NSMutableDictionary()
        
        
        param.setValue(deviceId, forKey: "deviceId")
        param.setValue(name, forKey: "name")
        param.setValue(password, forKey: "password")
        
        loadData(action: Api.DEVICE_ADD_PWD, param: param) { (jStr) in
            
            finishCallback()
            Utils.showHUD(info: "添加成功")
            
        }
        
    }
    
    
    
    func addUserDevice(deviceId:String,name:String,mobile:String,finishCallback: @escaping() ->()) {
        
        let param = NSMutableDictionary()
        
        
        param.setValue(deviceId, forKey: "deviceId")
        param.setValue(name, forKey: "name")
        param.setValue(mobile, forKey: "mobile")
        
        loadData(action: Api.DEVICE_ADDUSER_DEVICE, param: param) { (jStr) in
            
            Utils.showHUD(info: "添加成功")
            finishCallback()
            
        }
        
    }
    

}
