//
//  UnlockRecordViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/20.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class UnlockRecordViewModel: BaseViewModel {
    
     lazy var infoList = [UnlockTypeInfo]()
    
    func getLockRecord(deviceID:String,type:Int,finishedCallback : @escaping () -> ()){
        
        let param=NSMutableDictionary()
        var urlStr = ""
        
        if type == 1 {
            
            urlStr = Api.DEVICE_LOCK_RECORD
        }else if type == 2 {
            urlStr = Api.DEVICE_ALERT_RECORD
        }
        
        param.setValue(deviceID, forKey: "deviceId")
        
        loadData(action: urlStr, param: param) { (jsonStr) in
            
            
            
            if let result = CommonResult<PageRow<UnlockTypeInfo>>(JSONString: jsonStr){
                self.infoList = result.resultData.list
                finishedCallback()
            }
        }
        
    }
    

}
