//
//  MessageViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2018/10/24.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class MessageViewModel: BaseViewModel {
    
    var messageList = [MessageInfo]()
    
    
    func getMessagePushRecord(finishedCallback : @escaping () -> ()){
        
        let param = NSMutableDictionary()
        
      
        
        loadData(action: Api.DEVICE_MESSAGE_RECORD, param: param) { (jsonStr) in
            
            if let result = CommonResult<PageRow<MessageInfo>>(JSONString: jsonStr){
                
                self.messageList = result.resultData.list
                
                
                finishedCallback()
            }
            
            
        }
    }
    
    
    func getMessageDetail(recordId:Int, finishedCallback : @escaping () -> ()){
        
        let param = NSMutableDictionary()
        
        param.setValue(recordId, forKey: "id")
        
        loadData(action: Api.DEVICE_MESSAGE_DETAIL, param: param) { (jsonStr) in
            
       
            finishedCallback()
            
        }
    }
    
    
}
