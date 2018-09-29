//
//  ManagerDeviceViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/10.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class ManagerDeviceViewController: ThemeViewController {

   
    
    @IBOutlet weak var stateImageView: UIImageView!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var deviceButton: ButtonWithRightImage!
    
    private var titles = ["密码管理","指纹管理","卡片管理","设备成员","开锁记录","报警记录","删除设备"]

    fileprivate let viewModel = DeviceInfoViewModel.init()
    
    var deviceInfo = DeviceInfo()
    var deviceID = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getDeviceInfo()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeDeviceName(_ sender: Any) {
        
       
        showKWAlertView()
    }
    
    
}

extension ManagerDeviceViewController{
    
    func setupUI(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
//        
//        if deviceInfo.role != 0 {
//            
//            titles.remove(at: 6)
//            titles.remove(at: 7)
//            titles.remove(at: 8)
//        }
    
    }
    
    func getDeviceInfo(){
        
        
        deviceButton.setTitle(deviceInfo.name, for: .normal)
        
        if  self.deviceInfo.online == 1   {
            
            self.stateLabel.text = "正常运行"
            self.stateImageView.image = #imageLiteral(resourceName: "正常运行")
            
        }else {
            self.stateLabel.text = "已下线"
            self.stateImageView.image = #imageLiteral(resourceName: "有风险")
            
        }
    }
    
    func showKWAlertView(){
        
        
        guard deviceInfo.role == 0 else {
            
            return
        }
        
        let pswAlertView = KWAlertView.init(frame: self.view.bounds)
        let label = pswAlertView.BGView.viewWithTag(10) as! UILabel
        
        pswAlertView.delegate = self
        
        label.text = "修改设备名称"
    
        self.view.addSubview(pswAlertView)
        
    }
    
    
    func showPwdAlertView(){
        
        let alertView = PasswordAlertView.init(frame: self.view.bounds)
        let label = alertView.BGView.viewWithTag(10) as! UILabel
        alertView.delegate = self
        label.text = "验证管理员密码"
        self.view.addSubview(alertView)
    }

    
}

extension ManagerDeviceViewController:KWAlertViewDelegate {
   
    func passwordCompleteInAlertView(alertView: KWAlertView, name: String) {
        
        alertView.removeFromSuperview()
        
        self.viewModel.changeDeviceName(deviceID: deviceInfo.deviceId, name: name) {
            
            Utils.showHUD(info: "修改成功")
            self.deviceButton.setTitle(name, for: .normal)
            NotificationCenter.default.post(name: NOTIFY_DEVICEVC_DEVICE, object: self)
        }
       
    }
}


extension ManagerDeviceViewController:PasswordAlertViewDelegate {
    
    func passwordCompleteInAlertView(alertView: PasswordAlertView, password: String) {
        
        alertView.removeFromSuperview()
        
        self.viewModel.deleteDevice(deviceID: deviceInfo.deviceId, masterPassword: password) {
            
            Utils.showHUD(info: "设备已删除")
            NotificationCenter.default.post(name: NOTIFY_DEVICEVC_DEVICE, object: self)
            self.navigationController?.popViewController(animated: true)
        }
    }
}




extension ManagerDeviceViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    // #MARK: --UICollectionViewDataSource的代理方法
    
    /**
     - returns: Item的宽高
     */
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width:SCREEN_WIDTH/4, height: 100)
    }
    
    /**
     - 该方法是可选方法，默认为1
     - returns: CollectionView中section的个数
     */
    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        return 1
    }
    /**
     - returns: Section中Item的个数
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return titles.count
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "manager_device_cell", for: indexPath)
        (cell.viewWithTag(10) as! UIImageView).image = UIImage.init(named: titles[indexPath.row])
        (cell.viewWithTag(11) as! UILabel).text = titles[indexPath.row]
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        //某个Cell被选择的事件处理
        switch (indexPath.row) {
            
        case 0,1,2,3:
            
            var title:String?
            var type = indexPath.row + 1
            if indexPath.row == 0 {
                title = "密码管理"
            }else if indexPath.row == 1{
                title = "指纹管理"
            }else if indexPath.row == 2{
                title = "卡片管理"
            }else{
                title = "设备成员"
                type = 4
            }
            let managerVC = storyboard?.instantiateViewController(withIdentifier: "ManagerPWDVC") as! ManagerPWDViewController
            managerVC.titleName = title
            managerVC.deviceInfo = deviceInfo
            managerVC.typeID = type
            print(type)
            navigationController?.pushViewController(managerVC, animated: true)
//        case 6:
//            let heartVC = storyboard?.instantiateViewController(withIdentifier: "HeartBeatVC") as! HeartBeatViewController
//            heartVC.deviceInfo = deviceInfo
//            navigationController?.pushViewController(heartVC, animated: true)
        case 4,5:
            let recordVC = UIStoryboard.init(name: "Homepage", bundle: nil).instantiateViewController(withIdentifier: "UnlockRecordVC") as! UnlockRecordViewController
            recordVC.type = indexPath.row - 3
            recordVC.deviceID = deviceID
            navigationController?.pushViewController(recordVC, animated: true)
        case 6:
            
            if deviceInfo.role == 0 {
                
                showPwdAlertView()
                
            }else{
                
                Utils.showHUD(info: "没有管理员权限")
            }
//        case 7:
//
//            if deviceInfo.role == 0 {
//
//                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "ResetPwdVC") as! ResetPwdViewController
//                vc.type = 2
//                vc.deviceID = deviceInfo.deviceId
//                navigationController?.pushViewController(vc, animated: true)
//
//            }else{
//
//                Utils.showHUD(info: "没有管理员权限")
//            }
//

        default:
            break
        }
    }
    
}


