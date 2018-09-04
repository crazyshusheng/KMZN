//
//  Api.swift
//  KMZN
//
//  Created by 陈志超 on 2018/7/25.
//  Copyright © 2018年 czc. All rights reserved.
//

import Foundation

class Api{
    
    
    /** 注册登录 */
    static let USER_LOGIN = "/user/login" //普通登录
    static let USER_CODE_LOGIN = "/user/loginWithVCode" //验证码登录
    static let USER_REGISTER = "/user/register" //注册
    static let USER_RESET_PASSWORD = "/user/resetPassword" //重置密码(通过验证码)
    static let USER_UPDATE_PASSWORD = "/user/updatePassword" //修改密码
    static let USER_SEND_CODE = "/user/sendVCode" //发送验证码
    
    /** 设备 */
    static let DEVICE_CREATE_DEVICE = "/device/createDevice" //添加设备
    static let DEVICE_ADDUSER_DEVICE = "/device/addUserDevice" //关联用户
    static let DEVICE_DELETE_DEVICE = "/device/deleteUserDevice" //解除关联关系
    static let DEVICE_GET_USER = "/device/getDeviceUsers" //获取设备关联的用户
    static let DEVICE_GET_USERDEVICE = "/device/getUserDevices" //获取用户关联的设备
    static let DEVICE_SWITCH_CURRENT = "/device/switchCurrentDevice" //切换设备
    
    static let PRODUCT_LIST_INFO = "/device/getProductList" // 获取产品型号列表
    static let DEVICE_INFO = "/device/getInfo" //获取设备状态信息
    static let DEVICE_HEART_BEAT = "/device/setHeartBeat" //设置心跳时间
    static let DEVICE_MASTER_PWD = "/device/setMasterPassword" //设置管理员密码
    static let DEVICE_CKECK_PWD = "/device/checkMasterPassword" //验证管理员密码
    static let DEVICE_UPDATE_MASTERPWD = "/device/setMasterPassword" //修改管理员密码
    static let DEVICE_UPDATE_DEVICENAME = "/device/updateDeviceName"  
    
    static let DEVICE_OPENLOCK = "/device/openLock" //远程开锁
    static let DEVICE_LOCK_RECORD = "/record/getLockRecord" //开锁记录查询
    static let DEVICE_ALERT_RECORD = "/record/getAlertRecord" //报警记录查询
    
    
    static let DEVICE_GET_PASSLIST = "/pass/getPassList" //获取通行证(密码，指纹，卡)列表
    static let DEVICE_ADD_PWD = "/pass/addPassword" //添加密码
    static let DEVICE_DELETE_PWD = "/pass/deletePass" //删除密码
    static let DEVICE_UPDATE_NAME = "/pass/updateName" //修改名称
    static let DEVICE_DELETE_DEIVCE = "/device/deleteDevice" //删除设备
    static let DEVICE_CHECK_BIND = "/device/checkDeviceBind" // 是否可添加
    
    /** 个人设置 */
    
    static let USER_PHOTO_INFO = "/user/uploadAvatar" //头像文件
    static let USER_NAME_INFO = "/user/updateName" //名字
    
}


