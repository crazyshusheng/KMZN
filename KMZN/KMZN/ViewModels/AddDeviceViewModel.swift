//
//  AddDeviceViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/20.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class AddDeviceViewModel: BaseViewModel {
    
    
    lazy var lockInfo = LockDetailInfo()
    
    
    func addDevice(imei:String,imsi:String,name:String,modelNumber:String, masterPassword:String,finishedCallback : @escaping () -> ()){
    
         let param=NSMutableDictionary()
    
    
    
         param.setValue(imei, forKey: "imei")
         param.setValue(imsi, forKey: "imsi")
         param.setValue(name, forKey: "name")
         param.setValue(modelNumber, forKey: "modelNumber")
         param.setValue(masterPassword, forKey: "masterPassword")
    
          print(param)
    
        loadData(action: Api.DEVICE_CREATE_DEVICE, param: param) { (jsonStr) in
        
            if let result =  CommonResult<LockDetailInfo>(JSONString:jsonStr){
                
                Utils.showHUD(info: "添加设备成功")
                self.lockInfo = result.resultData
                
                UserSettings.shareInstance.setValue(key: UserSettings.DEVICE_ID, value: result.resultData.deviceId)
                
                NotificationCenter.default.post(name: NOTIFY_DEVICEVC_DEVICE, object: nil)
                
                NotificationCenter.default.post(name: NOTIFY_HOMEVC_REFRESH, object: nil)
             
                
                finishedCallback()
            }
        }
    }
    
    
    func checkDeviceBind(imei:String,finishedCallback : @escaping () -> ()){
    
        let param=NSMutableDictionary()
        param.setValue(imei, forKey: "imei")
      
        
        loadData(action: Api.DEVICE_CHECK_BIND, param: param) { (jsonStr) in
        
            
            finishedCallback()
        }
    }
    
    

}
