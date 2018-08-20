//
//  AddDeviceViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/10.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class AddDeviceViewController: ThemeViewController {
    
    @IBOutlet weak var eiTextField: UITextField!
    
    @IBOutlet weak var siTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    fileprivate let viewModel = AddDeviceViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func addDevice(_ sender: Any) {
        
        
        addDevice()
        
//        showPwdAlertView()
    }
    
}

extension AddDeviceViewController {
    
    
    func showPwdAlertView(){
        
        let pswAlertView = PasswordAlertView.init(frame: self.view.bounds)
        let label = pswAlertView.BGView.viewWithTag(10) as! UILabel
        label.text = "设备为初始状态，请先创建管理员密码"
        pswAlertView.delegate = self
        self.view.addSubview(pswAlertView)
        
    }
    
    
    func addDevice(){
        
        let eiCode = eiTextField.text!
        let siCode = siTextField.text!
        let name = nameTextField.text!
        
        if(eiCode.isEmpty){
            
            Utils.showHUD(info:"请输入IMEI序列号")
            
            return
        }
        if(siCode.isEmpty){
            
            Utils.showHUD(info:"请输入IMSI序列号")
            
            return
        }
        if(name.isEmpty){
            
            Utils.showHUD(info:"请输入设备名称")
            return
        }
    
        viewModel.addDevice(imei: eiCode, imsi: siCode, name: name) {
            
            
        }
    }

}



extension AddDeviceViewController:PasswordAlertViewDelegate {
    
    func passwordCompleteInAlertView(alertView: PasswordAlertView, password: String) {
        
        alertView.removeFromSuperview()
        print(password)
    }
}
