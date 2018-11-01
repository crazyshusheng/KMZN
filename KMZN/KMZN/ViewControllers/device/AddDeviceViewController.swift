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
    
    @IBOutlet weak var lockImageView: UIImageView!
    
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
        
       
        
        lockImageView?.kf.setImage(with: URL.init(string: productInfo.image))
        
    }
    

    @IBAction func addDevice(_ sender: Any) {
        
        
        addDevice(type: 1, pwd: "")
        
       
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
    
    
    func showPwdAlertView(){
        
        let pswAlertView = PasswordAlertView.init(frame: self.view.bounds)
        let label = pswAlertView.BGView.viewWithTag(10) as! UILabel
        label.text = "设备为初始状态，请先创建管理员密码"
        pswAlertView.delegate = self
        self.view.addSubview(pswAlertView)
        
    }
    
 
    
    
    
    func addDevice(type:Int,pwd:String){
        
        let eiCode = eiTextField.text!
        let siCode = siTextField.text!
        let name = nameTextField.text!
        
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
            
            self.navigationController?.popToRootViewController(animated: true)
        }
    
        
    
        
    }

}



extension AddDeviceViewController:PasswordAlertViewDelegate {
    
    func passwordCompleteInAlertView(alertView: PasswordAlertView, password: String) {
        
        alertView.removeFromSuperview()
        
        addDevice(type: 2, pwd: password)
    
    }
}
