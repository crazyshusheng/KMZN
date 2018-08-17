//
//  LoginViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/7/23.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class LoginViewController: ThemeViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    var registerVM = RegisterViewModel()
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        //去掉返回按钮文字
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: self, action: nil)
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setDefautValue()
        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
     
        userLogin()
    }
    

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension LoginViewController{
    
    
    
    func setDefautValue(){
        
        if let phone = UserSettings.shareInstance.getStringValue(key: UserSettings.USER_PHONE){
            
            usernameTextField.text = phone
        }
        if let pwd = UserSettings.shareInstance.getStringValue(key: UserSettings.USER_PASSWORD){
            
            pwdTextField.text = pwd
        }
        
        
    }
    
    
    
    
    func userLogin(){
        
        
        let phone = usernameTextField.text!
        let pwd = pwdTextField.text!
        
   
        if(phone.isEmpty || !Utils.isVailedPhone(phone: phone)){
            
            Utils.showHUD(info:"请输入手机号")
            
            return
        }
    
        if(pwd.isEmpty || !Utils.isVailedPassword(password: pwd) ){
            
            Utils.showHUD(info:"请输入密码")
            return
        }
        
        
        registerVM.login(phone: phone, pwd: pwd) {
            
           self.navigationController?.dismiss(animated: true, completion: nil)
           self.navigationController?.popViewController(animated: true)
            
        }
        
    }
    
}




