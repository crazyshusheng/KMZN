//
//  HttpWrapper.swift
//  KMZN
//
//  Created by 陈志超 on 2018/7/25.
//  Copyright © 2018年 czc. All rights reserved.
//

import Foundation
import AFNetworking
import SVProgressHUD

class HttpWrapper {
    
    static let shareInstance = HttpWrapper()//单例
    var manager:AFHTTPSessionManager!
    var reachability:AFNetworkReachabilityManager!
    var cookies:String!
    private init(){
        manager = AFHTTPSessionManager()
        manager.responseSerializer=AFHTTPResponseSerializer()
        manager.responseSerializer.acceptableContentTypes=["application/json","text/html", "text/json", "text/javascript","text/plain","image/gif"]
        reachability = AFNetworkReachabilityManager.shared()
        manager.requestSerializer.timeoutInterval = 10.0
    }
    //post请求封装
    func post(action:String,param:NSMutableDictionary?,loadSuccess:@escaping (String)->Void,loadFailed:@escaping (String)->Void) {
        
        
        guard  reachability.networkReachabilityStatus != .notReachable  else {
            SVProgressHUD.show(nil, status: "无网络连接")
            return
        }
        
        //判断token是否存在，并设置token
        if let token=UserSettings.shareInstance.getStringValue(key: UserSettings.TOKEN){
            manager.requestSerializer.setValue( token, forHTTPHeaderField:"token")
        }
        manager.post(action, parameters: param, progress: { (process) in}, success: { (dataTask, responseObject) in
            let respone =   dataTask.response as! HTTPURLResponse
            
            if let cookie = respone.allHeaderFields["Set-Cookie"] as? String{
                self.manager.requestSerializer.setValue(cookie, forHTTPHeaderField: "Cookie") //设置Cookies
                self.cookies=cookie
            }
            let data=responseObject as! Data
            if  let jsonStr=String(data: data , encoding: String.Encoding.utf8){
                if(JSONSerialization.isValidJSONObject(jsonStr)){
                    loadFailed(RESULT_CODE_SYSTEM_JSON_ERROR) //不是有效的JSON数据
                }else{
                    loadSuccess(jsonStr)
                }
            }else{
                loadFailed(RESULT_CODE_SYSTEM_JSON_ERROR) //服务器返回空数据信息
            }
            
        }) { (dataTask, e) in
            
            print(e.localizedDescription)
            loadFailed(RESULT_CODE_NETWORK_ERROR) //网络错误
        }
        
    }
    //上传文件
    func requestWithData(action:String,DataDic:NSMutableDictionary?,fileData:Data?,dataName:String,loadSuccess:@escaping (String)->Void,loadFailed:@escaping (String)->Void) {
        //判断token是否存在，并设置token
        if let token=UserSettings.shareInstance.getStringValue(key: UserSettings.TOKEN){
            manager.requestSerializer.setValue( token, forHTTPHeaderField:"token")
        }
        

        
        
        manager.post(action, parameters: DataDic, constructingBodyWith: { (formData:AFMultipartFormData?) in
            if let data=fileData{
                
                formData?.appendPart(withFileData: data, name: dataName, fileName: "file.jpg", mimeType: "image/jpeg")
            }
            
            
            
            
        }, progress: { (process) in}, success: { (dataTask, responseObject) in
            let respone =   dataTask.response as! HTTPURLResponse
            if let cookie = respone.allHeaderFields["Set-Cookie"] as? String{
                
                self.manager.requestSerializer.setValue(cookie, forHTTPHeaderField: "Cookie") //设置Cookies
            }
            let data=responseObject as! Data
            if  let jsonStr=String(data: data , encoding: String.Encoding.utf8){
                if(JSONSerialization.isValidJSONObject(jsonStr)){
                    loadFailed(RESULT_CODE_SYSTEM_JSON_ERROR) //不是有效的JSON数据
                }else{
                    loadSuccess(jsonStr)
                }
            }else{
                loadFailed(RESULT_CODE_SYSTEM_JSON_ERROR) //服务器返回空数据信息
            }
            
        }) { (dataTask, error) in
            print(error.localizedDescription)
            loadFailed(RESULT_CODE_NETWORK_ERROR) //网络错误
        }
        
        
    }
    
    // 下载文件
    func requestDownloadData(urlStr:String,fileStr:String) {
        
        //判断token是否存在，并设置token
        if let token=UserSettings.shareInstance.getStringValue(key: UserSettings.TOKEN){
            manager.requestSerializer.setValue( token, forHTTPHeaderField:"token")
        }
        
        
        manager.responseSerializer.acceptableContentTypes = ["application/json","text/html", "text/json", "text/javascript","pdf/exe","image/gif"]
        let request = URLRequest.init(url: URL.init(string: urlStr)!)
        print("文件下载")
        
        
        let downloadTast = manager.downloadTask(with: request, progress: { (progress) in
            print(progress)
        }, destination: { (targetPath, URLResponse) -> URL in
            
            var savePathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            savePathURL.appendPathComponent(fileStr)
            print(savePathURL)
            return  savePathURL
            
        }) { (response, url, error) in
            // 下载完成操作
            SVProgressHUD.show(nil, status: "下载完成")
        }
        
        //开始下载
        downloadTast.resume()
        
    }
    
}

