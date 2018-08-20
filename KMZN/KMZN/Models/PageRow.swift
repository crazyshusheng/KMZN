//
//  PageRow.swift
//  HomeHealth
//
//  Created by tongdow on 2017/7/15.
//  Copyright © 2017年 lexiang. All rights reserved.
//

import Foundation
import ObjectMapper
class PageRow<T: Mappable>: BaseMappable {
    var list:[T]!
    var total:Int!
    var pageNum:Int!
    var pageSize:Int!
    
    
    // Mappable
    override func mapping(map: Map) {
        list      <- map["list"]
        total <- map["pages"]
        pageNum <- map["pageNum"]
        pageSize <- map["pageSize"]
    }
}
