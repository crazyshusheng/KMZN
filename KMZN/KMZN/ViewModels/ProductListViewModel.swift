//
//  ProductListViewModel.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/24.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class ProductListViewModel: BaseViewModel {
    
    
    lazy var infoList = [ProductTypeInfo]()
    
    
    func getUserDevices(finishedCallback : @escaping () -> ()){
        
        
        loadData(action: Api.PRODUCT_LIST_INFO, param: nil) { (jsonStr) in
            
            if let result = CommonResult<PageRow<ProductTypeInfo>>(JSONString: jsonStr){
                
                self.infoList = result.resultData.list
                
                finishedCallback()
            }
          
        }
    }
    
    
}
