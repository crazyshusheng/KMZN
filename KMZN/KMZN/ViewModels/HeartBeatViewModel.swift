//
//  HeartBeatViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/28.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class HeartBeatViewModel: BaseViewModel {
    
    
  
    
    func setHeartBeat(deviceId:String,heartBeat:Int,finishedCallback : @escaping () -> ()){
        
        let param = NSMutableDictionary()
        
        param.setValue(deviceId, forKey: "deviceId")
        param.setValue(heartBeat, forKey: "heartBeat")
        
        loadData(action: Api.DEVICE_HEART_BEAT, param: param) { (jsonStr) in
            
            if CommonResult<BaseMappable>(JSONString: jsonStr) != nil{
                
                Utils.showHUD(info: "设置成功")
                finishedCallback()
            }
            
        }
    }
    
    
}
