//
//  UserInfoViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/29.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class UserInfoViewModel: BaseViewModel {
    
    var photoUrl = ""
    
    
    func setUserAvatar(imageData:Data,finishedCallback : @escaping () -> ()){
        
        postWithFile(action: Api.USER_PHOTO_INFO, param: nil, fileData: imageData, dataName: "avatar") { (jsonStr) in
            
            finishedCallback()
        }
        
    }
    
    
    func updateUserNickname(name:String,finishedCallback : @escaping () -> ()){
        
        let param = NSMutableDictionary()
        param.setValue(name, forKey: "name")
        
        loadData(action: Api.USER_NAME_INFO, param: param) { (jsonStr) in
            
            UserSettings.shareInstance.setValue(key: UserSettings.USER_NICK_NAME, value:name )
            
            finishedCallback()
        }
        
    }
    
    
    
    
    
    
    
    override func error(errorCode: String?, message: String?) {
        
        super.error(errorCode: errorCode, message: message)
        
        if errorCode == "00" && message!.count > 15 {
            
            photoUrl = message!
        }
        
    }
    
    
    
}
