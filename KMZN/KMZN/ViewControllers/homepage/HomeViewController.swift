//
//  HomeViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/8.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //判断是否登录 ！测试
        if(UserSettings.shareInstance.isLogin()){
            
            let storyBD = UIStoryboard.init(name: "Main", bundle: nil)
            let startvc = storyBD.instantiateViewController(withIdentifier: "startNVC")
            self.present(startvc, animated: false)

        }
        
       
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
