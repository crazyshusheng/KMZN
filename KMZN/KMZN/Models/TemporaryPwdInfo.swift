//
//  TemporaryPwdInfo.swift
//  KMZN
//
//  Created by 陈志超 on 2018/10/22.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit
import ObjectMapper

class TemporaryPwdInfo: BaseMappable {
    
    
    var deviceId:String!
    var passId:Int!
    var reocrdId:Int!
    var isTemporaryPassword:String!
    var name:String!
    var passGroup:String!
    var passType:Int!
    var password:String!
    var passwordBeginTime:String!
    var passwordEndTime:String!
    var passwordOnceExpire:String!
    var repeatCount:String!
    var repeatWeek:String!
    var status:String!
    var temporaryType:Int!
    
    var createTime:String!
    
    override func mapping(map: Map) {
        
        deviceId <- map["deviceId"]
        createTime <- (map["createTime"])
        passId <- map["passId"]
        isTemporaryPassword <- map["isTemporaryPassword"]
        passGroup <- map["passGroup"]
        name <- map["name"]
        reocrdId <- map["id"]
        passType <- map["passType"]
        password <- map["password"]
        passwordBeginTime <- map["passwordBeginTime"]
        passwordEndTime <- map["passwordEndTime"]
        passwordOnceExpire <- map["passwordOnceExpire"]
        repeatCount <- map["repeatCount"]
        repeatWeek <- map["repeatWeek"]
        status <- map["status"]
        temporaryType <- map["temporaryType"]
        
    }
    
    
}
