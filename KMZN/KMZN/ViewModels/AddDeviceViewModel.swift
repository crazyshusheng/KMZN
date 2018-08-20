//
//  AddDeviceViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/20.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class AddDeviceViewModel: BaseViewModel {
    
    
   func addDevice(imei:String,imsi:String,name:String,finishedCallback : @escaping () -> ()){
    
         let param=NSMutableDictionary()
         param.setValue(imei, forKey: "imei")
         param.setValue(imsi, forKey: "imsi")
         param.setValue(name, forKey: "name")
        loadData(action: Api.DEVICE_CREATE_DEVICE, param: param) { (jsonStr) in
        
            print(jsonStr)
        }
    }
    
    
    func setDeviceMasterPwd(deviceID:String,pwd:String,name:String,finishedCallback : @escaping () -> ()){
    
        let param=NSMutableDictionary()
        param.setValue(deviceID, forKey: "deviceId")
        param.setValue(pwd, forKey: "masterPassword")
        
        loadData(action: Api.DEVICE_MASTER_PWD, param: param) { (jsonStr) in
        
        }
    }
    
    

}
