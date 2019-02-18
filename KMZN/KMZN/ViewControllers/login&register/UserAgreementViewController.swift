//
//  UserAgreementViewController.swift
//  HomeHealth
//
//  Created by 陈志超 on 2017/9/4.
//  Copyright © 2017年 lexiang. All rights reserved.
//

import UIKit
import WebKit

class UserAgreementViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
  
    
    var htmlStr: String!
    
    var titleName:String!
    
   
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleName
      
        
        if let userUrl = URL.init(string:htmlStr){
            let urlRequest = URLRequest.init(url:userUrl )
            webView.load(urlRequest)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
