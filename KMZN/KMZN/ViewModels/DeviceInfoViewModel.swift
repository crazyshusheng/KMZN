//
//  DeviceInfoViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/20.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class DeviceInfoViewModel: BaseViewModel {
    
    
    lazy var deviceInfo = DeviceInfo()
    
    
    //获取设备信息
    func getDeviceInfo(deviceID:String,finishedCallback : @escaping () -> ()){
        
        let param=NSMutableDictionary()
        
        param.setValue(deviceID, forKey: "deviceId")
        
        loadData(action: Api.DEVICE_INFO, param: param) { (jsonStr) in
            
            
            if let result = CommonResult<DeviceInfo>(JSONString: jsonStr){
                
                guard result.resultData != nil else{
                    
                    return
                }
                self.deviceInfo = result.resultData
                finishedCallback()
            }
        }
        
    }
    
    
    // 修改设备名称
    func changeDeviceName(deviceID:String,name:String,finishedCallback : @escaping () -> ()){
        
        let param=NSMutableDictionary()
        
        param.setValue(deviceID, forKey: "deviceId")
        param.setValue(name, forKey: "name")
        
        loadData(action: Api.DEVICE_UPDATE_DEVICENAME, param: param) { (jsonStr) in
            
            finishedCallback()
        }
        
    }
    
    
    // 远程开锁
    func openLock(deviceID:String,masterPassword:String,finishedCallback : @escaping () -> ()){
        
        let param=NSMutableDictionary()
        
        param.setValue(deviceID, forKey: "deviceId")
        param.setValue(masterPassword, forKey: "masterPassword")
        
        loadData(action: Api.DEVICE_OPENLOCK, param: param) { (jsonStr) in
            
            finishedCallback()
            Utils.showHUD(info: "开锁成功")
        }
        
    }
    
    
    // 删除设备
    func deleteDevice(deviceID:String,masterPassword:String,finishedCallback : @escaping () -> ()){
        
        let param=NSMutableDictionary()
        
        param.setValue(deviceID, forKey: "deviceId")
        param.setValue(masterPassword, forKey: "masterPassword")
        
        loadData(action: Api.DEVICE_OPENLOCK, param: param) { (jsonStr) in
            
            finishedCallback()
            
        }
        
    }
  
    

}
