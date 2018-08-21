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
    
    
    func getDeviceInfo(deviceID:String,finishedCallback : @escaping () -> ()){
        
        let param=NSMutableDictionary()
        
        param.setValue(deviceID, forKey: "deviceId")
        
        loadData(action: Api.DEVICE_INFO, param: param) { (jsonStr) in
            
            
            
            if let result = CommonResult<DeviceInfo>(JSONString: jsonStr){
                
                self.deviceInfo = result.resultData
                finishedCallback()
            }
        }
        
    }

}
