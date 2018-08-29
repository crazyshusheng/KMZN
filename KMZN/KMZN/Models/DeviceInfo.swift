//
//  DeviceInfo.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/20.
//  Copyright © 2018年 czc. All rights reserved.
//  设备信息

import UIKit
import ObjectMapper

class DeviceInfo: BaseMappable {
    
    
    var battery:Int?
    var heartBeat:Int?
    var signal:Int!
    var status:Int!
    var deviceId:String!
    var name:String!
    var online:Int?
    var role:Int?
    var upadateTime:Date!
    
    override func mapping(map: Map) {
        
        battery <- map["battery"]
        heartBeat <- map["heartBeat"]
        signal <- map["signal"]
        status <- map["status"]
        online <- map["online"]
        deviceId <- map["deviceId"]
        name <- map["name"]
        role <- map["role"]
    }
    

}
