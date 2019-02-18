//
//  RecondListInfo.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/20.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

import ObjectMapper

class RecondListInfo: BaseMappable {
    
    
    var createTime:String!
    
    var deviceId:String!
    
    var role:Int!
    var name:String!
    
    var userId:Int!
    var recordID:Int! //id
    var status:Int!
    var passId:Int!  //管理员
    var passType:Int!
    var password:String!
    var avatar:String!
    var mobile:String!
  
    
    override func mapping(map: Map) {
        
      
        userId <- map["userId"]
        role <- map["role"]
        name <- map["name"]
        deviceId <- map["deviceId"]
        
        recordID <- map["id"]
        password <- map["password"]
        passId <- map["passId"]
        passType <- map["passType"]
        status <- map["status"]
        createTime <- (map["createTime"])
        avatar <- map["avatar"]
        mobile <- map["mobile"]
    }
    
    
}
