//
//  UnlockTypeInfo.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/20.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit
import ObjectMapper

class UnlockTypeInfo: BaseMappable {
    
    
    var eventType:Int!
    var recondID:Int!
    var operateId:Int!
    var operateType:Int!
    var time:String!
    var name:String!
    var alertType:Int!
    
    override func mapping(map: Map) {
        
        
        eventType <- map["eventType"]
        name <- map["name"]
        recondID <- map["id"]
        operateId <- map["operateId"]
        operateType <- map["operateType"]
        alertType <- map["alertType"]
        time <- map["time"]
        
    }
    

}
