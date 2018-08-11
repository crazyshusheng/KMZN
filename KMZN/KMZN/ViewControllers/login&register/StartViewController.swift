//
//  ViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/7/23.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
         self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func setupViews(){
        
        registerBtn.layer.borderWidth = 1
        registerBtn.layer.borderColor = THEME_RED_COLOR.cgColor
        
        //去掉返回按钮文字
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: self, action: nil)
        
        //返回按钮颜色
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        //修改导航栏背景色
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        //消除阴影
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

