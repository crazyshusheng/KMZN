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
    
    
    //获取通行证(密码，指纹，卡)列表

    func getDeviceInfo(deviceID:String,passType:String,finishedCallback : @escaping () -> ()){
        
        let param=NSMutableDictionary()
        
        param.setValue(deviceID, forKey: "deviceId")
        param.setValue(passType, forKey: "passType")
        
        loadData(action: Api.DEVICE_GET_PASSLIST, param: param) { (jsonStr) in
            
    
            if let result = CommonResult<PageRow<RecondListInfo>>(JSONString: jsonStr){
                
                self.recordList = result.resultData.list
                
                finishedCallback()
            }
        }
        
    }
    
    //获取关联用户
    func getDeviceUsers(deviceID:String,finishedCallback : @escaping () -> ()){
        
        let param=NSMutableDictionary()
        param.setValue(deviceID, forKey: "deviceId")
   
        loadData(action: Api.DEVICE_GET_USER, param: param) { (jsonStr) in
            
            
            
            if let result = CommonResult<PageRow<RecondListInfo>>(JSONString: jsonStr){
                
                self.recordList = result.resultData.list
                
                finishedCallback()
            }
        }
        
        
    }
    
    
    //删除通行证(密码，指纹，卡)列表
    func deletePasswordRecord(recordId:Int,deviceId:String,finishCallback: @escaping() ->()) {
        
        let param=NSMutableDictionary()
        param.setValue(recordId, forKey: "id")
        param.setValue(deviceId, forKey: "deviceId")
        
        
        
        loadData(action: Api.DEVICE_DELETE_PWD, param: param) { (jStr) in
            
            if CommonResult<BaseMappable>(JSONString:jStr) != nil{
                
                finishCallback()
                
                Utils.showHUD(info: "密码已删除")
                
            }
        }
        
    }
    
    
    func deleteUserDevice(deviceId:String,userId:Int,finishCallback: @escaping() ->()) {
        
        let param=NSMutableDictionary()
        
        
        param.setValue(deviceId, forKey: "deviceId")
        param.setValue(userId, forKey: "userId")
        
        loadData(action: Api.DEVICE_DELETE_DEVICE, param: param) { (jStr) in
            
            finishCallback()
            
            
        }
        
    }
    

}
