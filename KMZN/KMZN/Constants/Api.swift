//
//  Api.swift
//  KMZN
//
//  Created by 陈志超 on 2018/7/25.
//  Copyright © 2018年 czc. All rights reserved.
//

import Foundation

class Api{
    
 /* 注册登录 */
    static let USER_LOGIN = "/user/login" //普通登录
    static let USER_CODE_LOGIN = "/user/loginWithVCode" //验证码登录
    static let USER_REGISTER = "/user/register" //注册
    static let USER_RESET_PASSWORD = "/user/resetPassword" //重置密码(通过验证码)
    static let USER_UPDATE_PASSWORD = "/user/updatePassword" //修改密码
    static let USER_SEND_CODE = "/user/sendVCode" //发送验证码
    
    
}


