
import Foundation
import UIKit


public let THEME_RED_COLOR = UIColor.colorWithCustom(r: 0xc8, g: 0x0d, b: 0x18)

public let BASE_URL="http://39.108.7.110:8080/itlock-apiapp" //接口访问地址
public let WB_URL = "ws://39.108.7.110:6381/websocket"  //websocket链接地址

public let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.size.width
public let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.size.height
public let IS_IPHONE_X =  SCREEN_HEIGHT == 812 ? true : false


public let DATE_FORMAT_YYYY_MM_DD="yyyy-MM-dd" //日期格式化
public let DATE_FORMAT_YYYY_MM_DD_HH_MM="yyyy-MM-dd hh:mm" //日期格式化



/* 请求结果状态码 */
public let RESULT_CODE_SUCCESS = 1// 成功（请求执行成功）
public let RESULT_CODE_FAIL = 0// 失败（请求执行失败）
public let RESULT_CODE_CLIENT_ERROR = "400";// 客户端异常
public let RESULT_CODE_NETWORK_ERROR = "401";// 网络错误
public let RESULT_CODE_SYSTEM_ERROR = "500";// 系统异常
public let RESULT_CODE_SYSTEM_JSON_ERROR = "501"//服务器返回json错误
public let RESULT_CODE_LOGIN_NOLOGIN = -1// 未登录
public let RESULT_CODE_LOGIN_USER_ERROR = -2// 用户不存在
public let RESULT_CODE_LOGIN_PASSWORD_ERROR = -3// 密码错误
public let RESULT_CODE_LOGIN_USER_STATUS_INVALID = -4// 用户状态异常（未审核通过等）
