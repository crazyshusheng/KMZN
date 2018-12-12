//
//  AddPwdViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/20.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class AddPwdViewController: ThemeViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var pwdLabel: UILabel!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    var viewModel = AddPwdViewModel.init()
    
    var deviceID = ""
    
    var type = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       
        // Do any additional setup after loading the view.
    }

    @IBAction func confirm(_ sender: Any) {
        
        addPassword()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(true)
        
        Utils.hiddleHUD()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension AddPwdViewController{
    
    
    func setupUI(){
        
        if type == 1{
            navigationItem.title = "添加密码"
            pwdLabel.text = "密码"
            pwdTextField.placeholder = "输入六位数字密码"
        }else if type == 4 {
            
            navigationItem.title = "添加成员"
            pwdLabel.text = "手机号"
            pwdTextField.placeholder = "输入手机号"
        }
        
        let webSocket = KMWebSocket.sharedInstance()
        webSocket.webSocketDelegate = self
    }
    
    func addPassword(){
        
        let name = nameTextField.text!
        let pwd = pwdTextField.text!
       
        
        if(name.isEmpty ){
            
            Utils.showHUD(info:"请输入名称")
            
            return
        }
        
        
        if type == 1{
            
            if(pwd.isEmpty || pwd.count != 6){
                
                Utils.showHUD(info:"密码为六位数字")
                
                return
            }
            
            viewModel.addDevicePwd(deviceId: deviceID, name: name, password: pwd) {
                
                let vc = self.navigationController?.viewControllers[2] as? ManagerPWDViewController
                vc?.isRefresh = true
                
                self.navigationController?.popViewController(animated: true)
            }
            
        }else if type == 4 {
            
            if(pwd.isEmpty || !Utils.isVailedPhone(phone: pwd)){
                
                Utils.showHUD(info:"请输入手机号")
                
                return
            }
            
            viewModel.addUserDevice(deviceId: deviceID, name: name, mobile: pwd) {
                
                let vc = self.navigationController?.viewControllers[2] as? ManagerPWDViewController
                vc?.isRefresh = true
                
                self.navigationController?.popViewController(animated: true)
                
            }
            
        }
        
        
     
     
     

    }
    
}

extension AddPwdViewController:KMWebSocketDelegate{
    
    
    func websocketDidReceiveMessage(socket: KMWebSocket, text: String) {
        
        print(text)
        
        navigationController?.popViewController(animated: true)
        
        if let result = CommonResult<BaseMappable>(JSONString:text){
            
            Utils.showHUD(info: result.message)
            
            let vc = self.navigationController?.viewControllers[2] as? ManagerPWDViewController
            vc?.isRefresh = true
        }
        
    }
}


