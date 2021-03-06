//
//  CodeLoginViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/7/24.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class CodeLoginViewController: UIViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var codeButton: UIButton!
    
    
    var registerVM = RegisterViewModel()
    
    
    var countdownTimer: Timer?
    
    var remainingSeconds: Int = 0 {
        willSet {
            
            codeButton.setTitle("\(newValue)s", for: .normal)
            
            if newValue <= 0 {
                codeButton.setTitle("获取验证码", for: .normal)
                isCounting = false
            }
            
        }
    }
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(RegisterViewController.updateTime), userInfo: nil, repeats: true)
                remainingSeconds = 60//120s重发
                countdownTimer?.fire()
                codeButton.backgroundColor = UIColor.white
                
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                codeButton.backgroundColor=UIColor.clear
            }
            
            codeButton.isEnabled = !newValue
        }
    }
    
    
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        //去掉返回按钮文字
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: self, action: nil)
    }
    
    @IBAction func sendCode(_ sender: Any) {
        
    
        let phone = phoneTextField.text!
        if(Utils.isVailedPhone(phone: phone)){
            
            registerVM.sendCode(phone: phone, finishCallback: {
                
                self.isCounting = true
            })
            
        }else{
            
        }
        
    }
    
    @IBAction func login(_ sender: Any) {
        
        registerUser()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updateTime() {
        // 计时开始时，逐秒减少remainingSeconds的值
        remainingSeconds = remainingSeconds - 1
    }

}

extension CodeLoginViewController{
    
    func registerUser(){
        
        let phone = phoneTextField.text!
        let code = codeTextField.text!
     
        
        if(phone.isEmpty || !Utils.isVailedPhone(phone: phone)){
            
            Utils.showHUD(info:"请输入手机号")
            
            return
        }
        if(code.isEmpty){
            
            Utils.showHUD(info:"请输入验证码")
            
            return
        }
      
        registerVM.codeLogin(phone: phone, code: code, finishCallback: {
            
           
            
            
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
        })
    }
    
}

