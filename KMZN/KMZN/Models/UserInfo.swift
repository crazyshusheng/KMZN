//
//  UserInfo.swift
//  HomeHealth
//
//  Created by tongdow on 2017/7/10.
//  Copyright © 2017年 lexiang. All rights reserved.
//

import Foundation
import ObjectMapper
class UserInfo :BaseMappable {

    var userId:Int!
    var password:String!
    var mobile:String!
    var photoUrl:String!
    var token:String!

    
    override func mapping(map: Map) {
        
        userId <- map["id"]
        token <- map["token"]
        password <- map["password"]
        mobile <- map["mobile"]
        photoUrl <- map["photoUrl"]

    }
}
