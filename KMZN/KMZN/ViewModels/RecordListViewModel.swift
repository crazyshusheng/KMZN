//
//  RecordListViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/20.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class RecordListViewModel: BaseViewModel {
    
    lazy var recordList = [RecondListInfo]()
    
    
    func getDeviceInfo(deviceID:String,passType:String,finishedCallback : @escaping () -> ()){
        
        let param=NSMutableDictionary()
        
        param.setValue(deviceID, forKey: "deviceId")
        param.setValue(passType, forKey: "passType")
        
        loadData(action: Api.DEVICE_GET_PASSLIST, param: param) { (jsonStr) in
            
            print(passType,jsonStr)
            
            if let result = CommonResult<DeviceInfo>(JSONString: jsonStr){
                
            }
        }
        
    }
    
    func getDeviceUsers(deviceID:String,finishedCallback : @escaping () -> ()){
        
        let param=NSMutableDictionary()
        param.setValue(deviceID, forKey: "deviceId")
   
        loadData(action: Api.DEVICE_GET_USER, param: param) { (jsonStr) in
            
            print(jsonStr)
            
            if let result = CommonResult<PageRow<RecondListInfo>>(JSONString: jsonStr){
                
                self.recordList = result.resultData.list
                
                finishedCallback()
            }
        }
        
        
    }
    

}
