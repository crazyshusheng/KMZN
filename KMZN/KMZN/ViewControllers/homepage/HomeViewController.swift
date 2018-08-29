//
//  HomeViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/8.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit
import SVProgressHUD


class HomeViewController: BasicViewController {
    
    @IBOutlet weak var addAdeviceView: UIView!
    
    @IBOutlet weak var homeView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var batteryLabel: UILabel!
    
    @IBOutlet weak var signalLabel: UILabel!
    
    var deviceVM =  DeviceInfoViewModel()
    var deviceInfo = DeviceInfo()
   
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()
        
        setupUI()
        
        deviceVM.viewController = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(isRefreshUI), name: NOTIFY_HOMEVC_REFRESH, object: nil)
        
    
    }
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addDevice(_ sender: Any) {
        
        
        let storyboard = UIStoryboard.init(name: "Device", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TypeDeviceVC") as! TypeDeviceViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    @IBAction func unlockRecord(_ sender: Any) {
        
        guard deviceInfo.deviceId != nil  else {
            
            return
        }
        
    
        let recordVC = UIStoryboard.init(name: "Homepage", bundle: nil).instantiateViewController(withIdentifier: "UnlockRecordVC") as! UnlockRecordViewController
        recordVC.type = 1
        recordVC.deviceID = deviceInfo.deviceId
        navigationController?.pushViewController(recordVC, animated: true)
    }
    
    
    @IBAction func openLock(_ sender: Any) {
        
        showPwdAlertView()
    }
    
}
extension HomeViewController {
    
    func   setupUI(){
        
        //判断是否登录
        if(!UserSettings.shareInstance.isLogin()){
            
            let storyBD = UIStoryboard.init(name: "Main", bundle: nil)
            let startvc = storyBD.instantiateViewController(withIdentifier: "startNVC")
            self.present(startvc, animated: false)
            
        }else{
            
            //webSocket链接
            let webSocket = KMWebSocket.sharedInstance()
            webSocket.connectSever()
            
        }
        
        if let deviceID = UserSettings.shareInstance.getStringValue(key: UserSettings.DEVICE_ID){
            
            homeView.isHidden = false
            addAdeviceView.isHidden = true
            
            deviceVM.getDeviceInfo(deviceID:deviceID) {
                
                self.deviceInfo = self.deviceVM.deviceInfo
                self.nameLabel.text = self.deviceInfo.name
                self.welcomeLabel.text = "欢迎回家"
                if let battery = self.deviceInfo.battery {
                    
                    self.batteryLabel.text = String(battery)
                }
                self.statusLabel.text = (self.deviceInfo.online == 1) ? "正常运行" : "已离线"
            }
        }else {
        
            homeView.isHidden = true
            addAdeviceView.isHidden = false
        }
        
    }
    
    
    
    func showPwdAlertView(){
        
        let pswAlertView = PasswordAlertView.init(frame: self.view.bounds)
        let label = pswAlertView.BGView.viewWithTag(10) as! UILabel
        label.text = "验证管理员密码"
        pswAlertView.delegate = self
        self.view.addSubview(pswAlertView)
        
    }
    
    
    @objc func isRefreshUI(){
        
        setupUI()
    }
    
    
    
}

extension HomeViewController:PasswordAlertViewDelegate {
    
    func passwordCompleteInAlertView(alertView: PasswordAlertView, password: String) {
        
        alertView.removeFromSuperview()
        
        self.deviceVM.openLock(deviceID: self.deviceInfo.deviceId, masterPassword: password) {
            
            
        }
    }
}

