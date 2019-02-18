//
//  CommonResult.swift
//  KMZN
//
//  Created by 陈志超 on 2018/7/25.
//  Copyright © 2018年 czc. All rights reserved.
//

import Foundation
import ObjectMapper
class CommonResult<T: Mappable>: BaseMappable {
    
    var success:Bool!
    var code:String! //成功标识
    var message:String!
    var resultData:T!
    
    // Mappable
    override func mapping(map: Map) {
        
        success <- map["success"]
        code    <- map["code"]
        message       <- map["message"]
        resultData      <- map["data"]
    }
}

