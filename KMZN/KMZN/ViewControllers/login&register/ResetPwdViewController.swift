//
//  ResetPsdViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/7/24.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class ResetPwdViewController: UIViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendcode(_ sender: Any) {
        
        let phone = phoneTextField.text!
        if(Utils.isVailedPhone(phone: phone)){
            
            registerVM.sendCode(phone: phone, finishCallback: {
                
                self.isCounting = true
            })
            
        }else{
            
        }
    }
    

    
    
    @IBAction func confirm(_ sender: Any) {
        
        changePwd()
    }
    

    @objc func updateTime() {
        // 计时开始时，逐秒减少remainingSeconds的值
        remainingSeconds = remainingSeconds - 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }



}

extension ResetPwdViewController{
    
    func changePwd(){
        
        let phone = phoneTextField.text!
        let code = codeTextField.text!
        let pwd = pwdTextField.text!
        
        if(phone.isEmpty || !Utils.isVailedPhone(phone: phone)){
            
            Utils.showHUD(info:"请输入手机号")
            
            return
        }
        if(code.isEmpty){
            
            Utils.showHUD(info:"请输入验证码")
            
            return
        }
        if(pwd.isEmpty || !Utils.isVailedPassword(password: pwd) ){
            
            Utils.showHUD(info:"请输入密码")
            return
        }
        
        registerVM.resetPassword(password: pwd, mobile: phone, verificationCode: code) {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
}
