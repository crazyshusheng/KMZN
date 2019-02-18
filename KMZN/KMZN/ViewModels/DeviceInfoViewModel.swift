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
    lazy var dataList = [DeviceInfo]()
    
    
    //获取所有设备
    func getDeviceLists(finishedCallback : @escaping () -> ()){
        
        loadData(action: Api.DEVICE_GET_USERDEVICE, param: nil) { (jsonStr) in
            
            if let result = CommonResult<PageRow<DeviceInfo>>(JSONString: jsonStr){
                
        
                if result.resultData != nil {
                    
                      self.dataList = result.resultData.list
                
                    
                    for (index,device) in self.dataList.enumerated(){
                        
                        
                        if device.isChoose != nil {
                            
                            
                            if   device.isChoose {
                                
                                
                                self.dataList.remove(at: index)
                                self.dataList.insert(device, at: 0)
                                break
                            }
                        }
                    
                    }
                    
                }
                

                finishedCallback()
                
            }
        }
    }
    
    
    
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
    
    
    
    //选择当前设备
    func chooseCurrentDevice(deviceId:String,finishedCallback : @escaping () -> ()){
        
        let param=NSMutableDictionary()
        
        
        param.setValue(deviceId, forKey: "deviceId")
        
        
        loadData(action: Api.DEVICE_SWITCH_CURRENT, param: param) { (jsonStr) in
            
            
            
            
            finishedCallback()
            
        }
    }
    
    
    // 验证开锁密码
    func ckeckLockPassword(deviceID:String,masterPassword:String,finishedCallback : @escaping () -> ()){
        
        let param=NSMutableDictionary()
        
        param.setValue(deviceID, forKey: "deviceId")
        param.setValue(masterPassword, forKey: "masterPassword")
        
        loadData(action: Api.TEMPORARY_CKECKLOCK_PWD, param: param) { (jsonStr) in
            
            finishedCallback()
            
        }
        
    }
    
    
    
    // 解除关联关系
    func deleteDevice(deviceID:String,userID:String,finishedCallback : @escaping () -> ()){
        
        let param=NSMutableDictionary()
        
        param.setValue(deviceID, forKey: "deviceId")
        
        param.setValue(userID, forKey: "userId")
        
        loadData(action: Api.DEVICE_DELETE_USER_DEIVCE, param: param) { (jsonStr) in
            
            finishedCallback()
            
        }
        
    }
    
    
    
    

}
