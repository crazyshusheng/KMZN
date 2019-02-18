//
//  LoginViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/7/23.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

import ReactiveCocoa
import Result
import ReactiveSwift

class LoginViewController: ThemeViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    var registerVM = RegisterViewModel()
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupViews()
        bindViewModel()
//        setDefautValue()
        
        
       
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
    
    
    
    func setupViews(){
        
        
        
        //去掉返回按钮文字
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: self, action: nil)
        
        //返回按钮颜色
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        //修改导航栏背景色
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        //消除阴影
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    
    func setDefautValue(){
        
        if let phone = UserSettings.shareInstance.getStringValue(key: UserSettings.USER_PHONE){
            
            usernameTextField.text = phone
            
            
        }
        if let pwd = UserSettings.shareInstance.getStringValue(key: UserSettings.USER_PASSWORD){
            
            pwdTextField.text = pwd
        }
        
        
    }
    
    func  bindViewModel(){
        
        //初始化vm
        let viewModel = LoginViewModel.init(usernameTextField.reactive.continuousTextValues, pwdTextField.reactive.continuousTextValues)
        
        //把信号绑定给登录button
        
        
        
        loginButton.reactive.isEnabled <~ viewModel.loginEnable
        
        loginButton.reactive.backgroundColor <~ viewModel.tfColor
        
        //通过CocoaAction实现button的点击
        
//        loginButton.reactive.pressed = CocoaAction.init(viewModel.loginAction){ _ in
//
//            return (self.usernameTextField.text!,self.pwdTextField.text!)
//        }
//         //观察登录是否成功
//        viewModel.loginAction.values.observeValues { (success) in
//
//            if success {
//
//                print("login - success")
//                self.userLogin()
//            }
//        }
        
        
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
        
        usernameTextField.endEditing(true)
        pwdTextField.endEditing(true)
        
        
        registerVM.login(phone: phone, pwd: pwd) {

            //发送通知
           NotificationCenter.default.post(name: NOTIFY_HOMEVC_REFRESH, object: self)
           NotificationCenter.default.post(name: NOTIFY_DEVICEVC_DEVICE, object: self)
           NotificationCenter.default.post(name: NOTIFY_USERVC_DEVICE, object: self)
           NotificationCenter.default.post(name: NOTIFY_SETTING_DEVICE, object: self)

           self.dismiss(animated: true, completion: nil)



            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(UInt64(5)*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {

                if let userID =  UserSettings.shareInstance.getUserID() {



                    JPUSHService.setAlias(String(userID), completion: nil, seq: 0)

                }
            }


           self.navigationController?.popToRootViewController(animated: true)

        }

     }

}




