//
//  LockDetailInfo.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/27.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit


import ObjectMapper

class  LockDetailInfo: BaseMappable {
    
    
    var deviceId:String!
    var imei:String!
    var imsi:String!
    var masterPasswordSet:Bool!
    var modelNumber:String!
    var name:String!
    var online:Int?
    var role:Int?
    
  
    
    override func mapping(map: Map) {
        
        deviceId <- map["deviceId"]
        imei <- map["imei"]
        imsi <- map["imsi"]
        masterPasswordSet <- map["masterPasswordSet"]
        name <- map["name"]
        modelNumber <- map["modelNumber"]
        online <- map["online"]
        role <- map["role"]
        
        
    }
    
    
}
