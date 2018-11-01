//
//  MessageViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2018/10/24.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class MessageViewModel: BaseViewModel {
    
    
    
    
    func getMessagePushRecord(finishedCallback : @escaping () -> ()){
        
        let param = NSMutableDictionary()
        
      
        
        loadData(action: Api.DEVICE_MESSAGE_RECORD, param: param) { (jsonStr) in
            
           
            
        }
    }
    
    
}
