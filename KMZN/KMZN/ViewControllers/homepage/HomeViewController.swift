//
//  HomeViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/8.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit
import SVProgressHUD


class HomeViewController: UIViewController {
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var batteryLabel: UILabel!
    
    @IBOutlet weak var signalLabel: UILabel!
    
    var deviceVM =  DeviceInfoViewModel()
    var deviceInfo = DeviceInfo()
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()
        
        setupUI()
        
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unlockRecord(_ sender: Any) {
        
        
        let recordVC = UIStoryboard.init(name: "Homepage", bundle: nil).instantiateViewController(withIdentifier: "UnlockRecordVC") as! UnlockRecordViewController
        recordVC.type = 1
        recordVC.deviceID = deviceInfo.deviceId
        navigationController?.pushViewController(recordVC, animated: true)
    }
    
    
}
extension HomeViewController {
    
    
    func   setupUI(){
        
        
        //判断是否登录
        if(!UserSettings.shareInstance.isLogin()){
            
            let storyBD = UIStoryboard.init(name: "Main", bundle: nil)
            let startvc = storyBD.instantiateViewController(withIdentifier: "startNVC")
            self.present(startvc, animated: false)
            
        }
        
        //简历webSocket链接
        let webSocket = KMWebSocket.sharedInstance()
        webSocket.connectSever()
        
        if let deviceID = UserSettings.shareInstance.getStringValue(key: UserSettings.DEVICE_ID){
            
            deviceVM.getDeviceInfo(deviceID:deviceID) {
                
                self.deviceInfo = self.deviceVM.deviceInfo
                self.batteryLabel.text = "\(self.deviceInfo.battery!)%"
            }
        }
        
      
        
        
        //测试设备
        UserSettings.shareInstance.setValue(key: UserSettings.DEVICE_IMEI, value:"869405031814545")
        UserSettings.shareInstance.setValue(key: UserSettings.DEVICE_IMSI, value:"460042304905726")
        UserSettings.shareInstance.setValue(key: UserSettings.DEVICE_ID, value:"39090334")
        


        
        
       
    }
    
    
}

