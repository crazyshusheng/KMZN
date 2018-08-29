//
//  ProductTypeInfo.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/27.
//  Copyright © 2018年 czc. All rights reserved.
//  设备类型

import UIKit

import ObjectMapper

class ProductTypeInfo: BaseMappable {
    
    
    var image:String!
    var modelNumber:String!
   
    var createDate:Date!
    
    override func mapping(map: Map) {
        
        image <- map["image"]
        modelNumber <- map["modelNumber"]
        
        createDate <- (map["createDate"],DateTransform())
    }
    
    
}
