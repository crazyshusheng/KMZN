
import Foundation
import UIKit


public let THEME_BG_COLOR = UIColor.colorWithCustom(r: 50, g: 150, b: 255)

public let BASE_URL = "http://www.homehealth.top/itlock-apiapp" //接口访问地址
public let WB_URL = "ws://www.homehealth.top:6381/websocket"  //websocket链接地址

public let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.size.width
public let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.size.height


public let IS_IPHONE_X =  SCREEN_HEIGHT == 812 ? true : false
public let NAVIGATION_BAR_HEIGHT:CGFloat = IS_IPHONE_X ? 88 : 64

public let DATE_FORMAT_YYYY_MM_DD="yyyy-MM-dd" //日期格式化
public let DATE_FORMAT_YYYY_MM_DD_HH_MM="yyyy-MM-dd hh:mm" //日期格式化


public var DEVICE_TOKEN:String! //设备通知码

/**
 请求结果状态码
 */
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


public let UNLOCK_TYPE:Dictionary<String,String> = ["0":"命令开锁","1":"钥匙开锁","2":"指纹开锁","3":"IC卡开锁","4":"密码开锁"] //开锁类型
public let ALERT_TYPE:Dictionary<String,String> = ["1":"低电压报警","2":"错误次数报警","3":"防撬报警"]

//MARK: 通知常量

public let NOTIFY_HOMEVC_REFRESH = NSNotification.Name("homeVCReferesh")  //首页刷新通知

public let NOTIFY_DEVICEVC_DEVICE = NSNotification.Name("deviceVCReresh")


public let NOTIFY_USERVC_DEVICE = NSNotification.Name("userVCReresh")

public let NOTIFY_SETTING_DEVICE = NSNotification.Name("settingVCReresh")
