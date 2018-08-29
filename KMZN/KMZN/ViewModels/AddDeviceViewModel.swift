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
    
    
    func addDevice(imei:String,imsi:String,name:String,modelNumber:String,finishedCallback : @escaping () -> ()){
    
         let param=NSMutableDictionary()
    
    
    
         param.setValue(imei, forKey: "imei")
         param.setValue(imsi, forKey: "imsi")
         param.setValue(name, forKey: "name")
         param.setValue(modelNumber, forKey: "modelNumber")
    
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
    
    
    func setDeviceMasterPwd(deviceID:String,pwd:String,name:String,finishedCallback : @escaping () -> ()){
    
        let param=NSMutableDictionary()
        param.setValue(deviceID, forKey: "deviceId")
        param.setValue(pwd, forKey: "masterPassword")
        
        loadData(action: Api.DEVICE_MASTER_PWD, param: param) { (jsonStr) in
        
            Utils.showHUD(info: "设置成功")
            finishedCallback()
        }
    }
    
    

}
