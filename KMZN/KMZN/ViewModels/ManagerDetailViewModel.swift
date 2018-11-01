//
//  ManagerDetailViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/21.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class ManagerDetailViewModel: BaseViewModel {
    
    

    //删除通行证(密码，指纹，卡)列表
    func deletePasswordRecord(recordId:Int,deviceId:String,finishCallback: @escaping() ->()) {
        
        let param=NSMutableDictionary()
        param.setValue(recordId, forKey: "id")
        param.setValue(deviceId, forKey: "deviceId")
        
     
    
        loadData(action: Api.DEVICE_DELETE_PWD, param: param) { (jStr) in
            
            if CommonResult<BaseMappable>(JSONString:jStr) != nil{
                
                finishCallback()

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
    
    func updateName(name:String,passID:Int,finishCallback: @escaping() ->()) {
        
        let param=NSMutableDictionary()
        
        
        param.setValue(name, forKey: "name")
        param.setValue(passID, forKey: "id")
        
        loadData(action: Api.DEVICE_UPDATE_NAME, param: param) { (jStr) in
            
            finishCallback()
            
        }
        
    }
    
    
}

