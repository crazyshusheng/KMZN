//
//  AddDeviceViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/10.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit
import Kingfisher

class AddDeviceViewController: ThemeViewController {
    

    
    @IBOutlet weak var eiTextField: UITextField!
    
    @IBOutlet weak var siTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
    
    let viewModel = AddDeviceViewModel.init()
    
    var productInfo: ProductTypeInfo!
    var lockInfo :LockDetailInfo!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupUI(){
        
       
        eiTextField.delegate = self
        siTextField.delegate = self
        
    }
    

    @IBAction func addDevice(_ sender: Any) {
        
        
        addDevice()
        
       
    }
    
    
    @IBAction func imeiQRCode(_ sender: Any) {
        
        let qrVc = QRCodeViewController()
        qrVc.codeType = 0
        qrVc.delegate = self
        navigationController?.pushViewController(qrVc, animated: true)
        
    }
    
    
    @IBAction func imseQRCode(_ sender: Any) {
        
        let qrVc = QRCodeViewController()
        qrVc.codeType = 1
        qrVc.delegate = self
        navigationController?.pushViewController(qrVc, animated: true)
        
    }
    
}

extension AddDeviceViewController:QRCodeViewControllerDelegate {
    
    func scanInfo(codeInfo: String, type: Int) {
        
        
        if type == 0{
            
            eiTextField.text = codeInfo
        }else{
            
            siTextField.text = codeInfo
        }
        
        
    }
    
}



extension AddDeviceViewController {
    
    

 
    func addDevice(){
        
        let eiCode = eiTextField.text!
        var siCode = siTextField.text!
        let name = nameTextField.text!
        siCode = "012345678912345"
        
        if(eiCode.isEmpty || !Utils.isVailedIMCode(code: eiCode)){
            
            Utils.showHUD(info:"请输入正确的IMEI序列号")
            
            return
        }
        if(siCode.isEmpty || !Utils.isVailedIMCode(code: siCode)){
            
            Utils.showHUD(info:"请输入正确的IMSI序列号")
            
            return
        }
        if(name.isEmpty){
            
            Utils.showHUD(info:"请输入设备名称")
            return
        }
        
        viewModel.addDevice(imei: eiCode, imsi: siCode, name: name, modelNumber: productInfo.modelNumber) {
            
            
             NotificationCenter.default.post(name: NOTIFY_DEVICEVC_DEVICE, object: self)
            
            self.navigationController?.popToRootViewController(animated: true)
        }
    

    }

}

extension AddDeviceViewController:UITextFieldDelegate{
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if string.count == 0 {//判断是是否为删除键
            return true
        }else if (textField.text?.count)! >= 15 {
            //当输入的密码大于等于15位后就忽略
            return false
        } else {
            return true
        }
    }
    
}





