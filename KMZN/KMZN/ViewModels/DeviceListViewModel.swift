//
//  DeviceListViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/23.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class DeviceListViewModel: BaseViewModel {
    
    
     lazy var infoList = [DeviceInfo]()
    
    
    func getUserDevices(isSort:Bool,finishedCallback : @escaping () -> ()){
        
      
        loadData(action: Api.DEVICE_GET_USERDEVICE, param: nil) { (jsonStr) in
            
            if let result = CommonResult<PageRow<DeviceInfo>>(JSONString: jsonStr){
                
                guard result.resultData.list.count > 0 else{
                    
                    return
                }
                
                var dataList = result.resultData.list!
                
                
                if isSort && result.resultData.list.count > 1 {
                
                    var deviceInfo = DeviceInfo()
                    
                    for (index,device) in dataList.enumerated() {
                        
                        if let deviceID = UserSettings.shareInstance.getStringValue(key: UserSettings.DEVICE_ID) {
                            
                            if Int(device.deviceId) == Int(deviceID) {
                                
                                dataList.remove(at: index)
                                deviceInfo = device
                                break
                            }
                        }
                    }
                    dataList.insert(deviceInfo, at: 0)
                }
               
               self.infoList = dataList
               
                
               finishedCallback()
            }
        }
    }
    
    
    
    func chooseCurrentDevice(deviceId:String,finishedCallback : @escaping () -> ()){
        
        let param=NSMutableDictionary()
        
    
        param.setValue(deviceId, forKey: "deviceId")
        
        
        loadData(action: Api.DEVICE_SWITCH_CURRENT, param: param) { (jsonStr) in
            
            
            Utils.showHUD(info: "切换设备成功")
            UserSettings.shareInstance.setValue(key: UserSettings.DEVICE_ID, value:deviceId)
            
            finishedCallback()
            
        }
    }
    
    

}
