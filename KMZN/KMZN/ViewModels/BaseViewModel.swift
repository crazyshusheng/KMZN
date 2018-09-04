//
//  BaseViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2018/7/25.
//  Copyright © 2018年 czc. All rights reserved.
//

import Foundation
import ObjectMapper
import SVProgressHUD

class BaseViewModel{
    
    
    var viewController = UIViewController()
    

}

extension BaseViewModel {
    
    
    func loadData(action:String,param:NSMutableDictionary?,loadSuccess:@escaping (String)->()){
        
        HttpWrapper.shareInstance.post(action: BASE_URL.appending(action), param: param, loadSuccess: { (resultData) in
            
            print(resultData)
            
             //json转对象
            if let result = CommonResult<BaseMappable>(JSONString:resultData){
            
                
                if result.success {
                  
                    loadSuccess(resultData)
                    
                }else{
                    
                    self.error(errorCode: result.code, message:result.message)
                }
                
            }else{
                
                //对象转化失败
                self.error(errorCode: RESULT_CODE_SYSTEM_JSON_ERROR,message: "数据解析失败")
            }
            
        }) { (errorCode) in
            
             self.error(errorCode: errorCode,message: nil)
            
        }
        
    }
    
    
    func postWithFile(action:String,param:NSMutableDictionary?,fileData:Data?,dataName:String,loadSuccess:@escaping (String)->Void)
    {
        HttpWrapper.shareInstance.requestWithData(action: BASE_URL.appending(action), DataDic: param, fileData: fileData, dataName: dataName, loadSuccess: { (jsonString) in
            
            print(jsonString)
          
            if  let result=CommonResult<BaseMappable>(JSONString: jsonString){
                if(result.success){
                    
                    self.error(errorCode: result.code, message:result.message)
                    //请求数据成功，处理
                    loadSuccess(jsonString)
                    
                    
                }else{
                    self.error(errorCode: result.code, message:result.message)
                    
                }
            }else{
                //对象转化失败
                self.error(errorCode: RESULT_CODE_SYSTEM_JSON_ERROR,message: "数据解析失败")
                
            }
        }, loadFailed: { (errorCode) in
            self.error(errorCode: errorCode,message: nil)
        })
        
        
        
    }
    
    
    
    
    //错误处理
    @objc func error(errorCode:String?,message:String?){
        
        guard errorCode != "00" else {
            return
        }
        
        var errorMsg = message
        
        if message != nil {
            
            if errorCode == "001" {
                
                errorMsg = "登录失效，请重新登录"

            }
            Utils.showHUD(info: errorMsg!)
            
            if errorCode == "001" {
            
                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                let startvc = storyBoard.instantiateViewController(withIdentifier: "startNVC")
                self.viewController.present(startvc, animated: false)
            }
            
        }
    }
    
    
}




