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
    
    
    

}

extension BaseViewModel {
    
    
    func loadData(action:String,param:NSMutableDictionary?,loadSuccess:@escaping (String)->()){
        
        HttpWrapper.shareInstance.post(action: BASE_URL.appending(action), param: param, loadSuccess: { (resultData) in
            
            
             //json转对象
            if let result = CommonResult<BaseMappable>(JSONString:resultData){
                
                if result.success {
                  
                    loadSuccess(resultData)
                    
                }else{
                    
                    self.error(errorCode: result.code, message:result.message)
                }
                
            }else{
                
                //对象转化失败
                self.error(errorCode: RESULT_CODE_SYSTEM_JSON_ERROR,message: "数据解析失败!")
            }
            
        }) { (errorCode) in
            
             self.error(errorCode: errorCode,message: nil)
            
        }
        
    }
    
    
    //错误处理
    func error(errorCode:String?,message:String?){
        
        
        print(message)
    }
    
    
    
    func showHUD(info:String){
        
        SVProgressHUD.show(nil, status: info)
    }
    
}




