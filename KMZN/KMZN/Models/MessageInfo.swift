//
//  MessageInfo.swift
//  KMZN
//
//  Created by 陈志超 on 2018/11/14.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit
import ObjectMapper

class MessageInfo: BaseMappable {
    
    
    var createTime:Date!
    var isCheck:String!
    var message:String!
    var recordId:Int!
  
    
    override func mapping(map: Map) {
        
        
        createTime <- (map["createTime"],KMDataTransform())
        isCheck <- map["isCheck"]
       
        message <- map["message"]
        recordId <- map["id"]
    
    }
    
    
}
