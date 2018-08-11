//
//  Utils.swift
//  SMSApp
//
//  Created by tongdow on 2017/6/30.
//  Copyright © 2017年 tongdow. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class Utils {
    
    
    class func showHUD(info:String){
        
        SVProgressHUD.show(nil, status: info)
    }
    
    
    // 日期类型格式化
    class func getDateStrFromTime(time:Int,formatStr:String="yyyy-MM-dd HH:mm:ss")->String {
        let format=DateFormatter()
        format.dateFormat=formatStr
        
        return format.string(from: NSDate(timeIntervalSince1970: TimeInterval(time)) as Date)
    }
    // 格式化日期转date
    class func getDateFromStr(datastr:String,formatStr:String="yyyy-MM-dd HH:mm:ss")->Date {
        let format=DateFormatter()
        format.dateFormat=formatStr
        return  format.date(from:datastr )!
    }
    
    //获取时间格式化输出
    class func getTimeStrFormTime(time:Int)->String{
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = time / 3600
        return  String(format: "%02d:%02d:%02d",hours,minutes,seconds)
        
    }
    
    
    //有效的密码 6-20为字母或数字组合
    class func isVailedPassword(password:String)->Bool{
        do {
            
            let pattern="^[a-zA-Z0-9]{6,12}$"
            // - 2、创建正则表达式对象
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            // - 3、开始匹配
            let matchs = regex.matches(in: password, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, password.characters.count))
            
            return matchs.count>0
            
        }catch {
            
        }
        return false
    }
    
    
    //有效的用户名 2-10个汉字
    class func isVailedUsername(username:String)->Bool{
        do {
            
            let pattern="^[\\u4e00-\\u9fa5]{2,10}$"
            // - 2、创建正则表达式对象
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            // - 3、开始匹配
            let matchs = regex.matches(in: username, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, username.characters.count))
            
            return matchs.count>0
            
        }catch {
            
        }
        return false
    }
    
    
    //判断有效电话号码
    class func isVailedPhone(phone:String)->Bool{
        do {
            
            let pattern="^[1][35789][0-9]{9}$"
            // - 2、创建正则表达式对象
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            // - 3、开始匹配
            let matchs = regex.matches(in: phone, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, phone.characters.count))
            
            return matchs.count>0
            
        }catch {
            
        }
        return false
    }
    
    
    //统计缓存文件大小
    class func fileSizeOfCache()-> String {
        
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
       
        
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        //快速枚举出所有文件名 计算文件大小
        var size:Double = 0
        for file in fileArr! {
            
            // 把文件名拼接到路径中
            let path = cachePath! + "/\(file)"
            
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            
            // 用元组取出文件大小属性
            for (abc, bcd) in floder {
                // 累加文件大小
                if abc ==  FileAttributeKey.size{
                    
                    size =  (bcd as AnyObject).doubleValue + size
                    
                
                }
                
            }
        }
        
        let mm = size / 1024 / 1024
        
        return String(format: "%.1f",mm)
    }
    
    //删除缓存文件
    class func clearCache() {
        
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        // 遍历删除
        for file in fileArr! {
            
            let path = cachePath! + "/\(file)"
            
            if FileManager.default.fileExists(atPath: path) {
                
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {
                    
                }
            }
        }
    }
    

    
    // 根据内容计算高度
   class func viewHight (content: String?,space:Int = 15,font: Int = 15) -> CGFloat {
        
        guard content != nil else {
            return 0
        }
        
        let rect: CGRect = content!.boundingRect(
            with: CGSize.init(width: SCREEN_WIDTH - 15, height: 0),
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: [NSAttributedStringKey.font:
                UIFont.systemFont(ofSize: 15)],
            context: nil)
        
        return rect.height + 10
    }
    
    
}
