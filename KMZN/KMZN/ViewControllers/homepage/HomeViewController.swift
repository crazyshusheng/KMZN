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
    
   

    @IBOutlet weak var addView: UIView!
    
    @IBOutlet weak var btnView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
  
    var activeView:UIView!
    
    var deviceVM =  DeviceInfoViewModel()
    
    var deviceList = [DeviceInfo]()
   
    
    var scrollIndex = 0 {
        
        didSet{
            
            self.deviceVM.chooseCurrentDevice(deviceId: deviceList[scrollIndex].deviceId) {
                
            }
        }
    }
    
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()
        
        

        deviceVM.viewController = self
        
        
        let socket = KMWebSocket.sharedInstance()
        socket.webSocketDelegate = self
       
        NotificationCenter.default.addObserver(self, selector: #selector(isRefreshUI), name: NOTIFY_HOMEVC_REFRESH, object: nil)
        
        if(!UserSettings.shareInstance.isLogin()){
            

            
            let storyBD = UIStoryboard.init(name: "Main", bundle: nil)
            let startvc = storyBD.instantiateViewController(withIdentifier: "startNVC")
            self.present(startvc, animated: false)
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        setupUI()
    }
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addLockDevice(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "Device", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DeviceTypeVC") as! DeviceTypeViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    

    
    
    @IBAction func unlockRecord(_ sender: Any) {
        
    
        let recordVC = UIStoryboard.init(name: "Homepage", bundle: nil).instantiateViewController(withIdentifier: "UnlockRecordVC") as! UnlockRecordViewController
        recordVC.type = 1
        
        if let deviceId = deviceList[scrollIndex].deviceId {
            
             recordVC.deviceID = deviceId
        }
       
        navigationController?.pushViewController(recordVC, animated: true)
    }
    
    @IBAction func creatTemporaryPwd(_ sender: Any) {
        
       
        showPwdAlertView()
        
      
    }
    
    @IBAction func showAlertList(_ sender: Any) {
        
        let recordVC = UIStoryboard.init(name: "Homepage", bundle: nil).instantiateViewController(withIdentifier: "UnlockRecordVC") as! UnlockRecordViewController
        recordVC.type = 2
        if let deviceId =  deviceList[scrollIndex].deviceId {
            
            recordVC.deviceID = deviceId
        }
        navigationController?.pushViewController(recordVC, animated: true)
        
        
    }
    
    
}
extension HomeViewController {
    
    
    
    func setupScrollView(){
        
        scrollView.delegate = self
        
        scrollView.contentSize = CGSize.init(width: scrollView.frame.size.width * CGFloat(deviceList.count), height: 0)
        
        for (i,info) in deviceList.enumerated() {
            
            let deviceView = Bundle.main.loadNibNamed("homeDeviceView", owner: nil, options: nil)!.first as! HomeDeviceView
          
            
            deviceView.frame = CGRect.init(x: scrollView.frame.size.width *  CGFloat(i), y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
           
            deviceView.deviceInfo = info
            
            if i == 0 {
                
                deviceView.leftView.isHidden = true
                
                if deviceList.count == 1{
                    
                    deviceView.rightView.isHidden = true
                }else{
                    deviceView.rightView.isHidden = false
                }
                
                
            }else if i == deviceList.count - 1{
                
                deviceView.leftView.isHidden = false
                deviceView.rightView.isHidden = true
                
            }else {
                
                deviceView.leftView.isHidden = false
                deviceView.rightView.isHidden = false
            }
            
            scrollView.addSubview(deviceView)
        }
    }
    
    
    
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
        
        deviceVM.getDeviceLists {
            
            self.deviceList = self.deviceVM.dataList
            
            if self.deviceList.count == 0 {
                
                self.scrollView.isHidden = true
                self.addView.isHidden = false
                self.refreshBtnView(isSelect: false)
                
            }else{
                
                self.scrollView.isHidden = false
                self.addView.isHidden = true
                self.refreshBtnView(isSelect: true)
                //设备变化
               self.setupScrollView()
            }
            
        }
        
        
    }

    
    
    func showPwdAlertView(){
        
        let pswAlertView = PasswordAlertView.init(frame: self.view.bounds)
        let label = pswAlertView.BGView.viewWithTag(10) as! UILabel
        label.text = "输入开锁密码"
        pswAlertView.delegate = self
        self.view.addSubview(pswAlertView)
        
    }
    
    
    @objc func isRefreshUI(){
        
        setupUI()
    }
    
    func refreshBtnView(isSelect:Bool){
        
        
        for i in 10...12{
            
            (btnView.viewWithTag(i) as! UIButton).isSelected  = isSelect
            
             (btnView.viewWithTag(i) as! UIButton).isUserInteractionEnabled = isSelect
            
        }
        
        
    }
    
    
    
}


extension HomeViewController:UIScrollViewDelegate{
    
    
    
 
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        
        scrollIndex = (Int(scrollView.contentOffset.x)/Int(self.view.frame.size.width))
        
       
    }
    
}


extension HomeViewController:PasswordAlertViewDelegate {
    
    func passwordCompleteInAlertView(alertView: PasswordAlertView, password: String) {
        
        alertView.removeFromSuperview()
        
        
        guard  deviceList[scrollIndex].deviceId != nil  else {
            
            return
        }
        
        
        self.deviceVM.ckeckLockPassword(deviceID: self.deviceList[scrollIndex].deviceId, masterPassword: password) {
            
          
            let pwdVC = UIStoryboard.init(name: "Homepage", bundle: nil).instantiateViewController(withIdentifier: "PwdListVC") as! PwdListViewController
            
            pwdVC.deviceID = self.deviceList[self.scrollIndex].deviceId
            pwdVC.masterPwd = password
            
            self.navigationController?.pushViewController(pwdVC, animated: true)
        }
    
        
    }
}


extension HomeViewController:KMWebSocketDelegate{
    
    
    func websocketDidReceiveMessage(socket: KMWebSocket, text: String) {
        
        
        print(text)
        
        if activeView != nil {
            
            activeView.removeFromSuperview()
        }
        
        if let result = CommonResult<BaseMappable>(JSONString:text){
            
            Utils.showHUD(info: result.message)
        }
        
    }
    
    
    func websocketDidConnect(sock: KMWebSocket){
        
        
    }
    
    func websocketDidDisconnect(socket: KMWebSocket, error: Error?){
        
    }
}


