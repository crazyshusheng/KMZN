//
//  DeviceViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/10.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import MJRefresh

class DeviceViewController: BasicViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = DeviceInfoViewModel()
    
    var dataList = [DeviceInfo]()
    
    var deviceInfo = DeviceInfo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    
        
        viewModel.viewController = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshDeviceUI), name: NOTIFY_DEVICEVC_DEVICE, object: nil)
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        
        
        self.tabBarController?.tabBar.isHidden = false
        
        loadData()
    }
    

    


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension DeviceViewController{
    
    
    func setupUI(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "DeviceInfoCell", bundle: nil), forCellReuseIdentifier: "deviceInfocell")
        tableView.separatorStyle = .none //去掉cell的分界线
        tableView.emptyDataSetSource = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "+添加"), style: .plain, target: self, action: #selector(addDevice))
        navigationItem.title = "设备"
        
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(loadData))
        tableView.mj_header = header
    }
    
    
   
    
    
    
    @objc func loadData(){
        
        
        viewModel.getDeviceLists {
            
            self.dataList = self.viewModel.dataList
            self.tableView.reloadData()
            self.tableView.mj_header.state = .idle
        }
   
    }
    
    @objc func refreshDeviceUI(){
        
         loadData()
    }
    
    @objc func addDevice(){
        
        
        let addDeviceVC = storyboard?.instantiateViewController(withIdentifier: "DeviceTypeVC") as! DeviceTypeViewController
        
        navigationController?.pushViewController(addDeviceVC, animated: true)
        
    }
    
    
    
    func showPwdAlertView(){
        
        let alertView = PasswordAlertView.init(frame: self.view.bounds)
        let label = alertView.BGView.viewWithTag(10) as! UILabel
        alertView.delegate = self
        label.text = "验证管理员密码"
        self.view.addSubview(alertView)
    }
    
    override func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return #imageLiteral(resourceName: "暂无设备")
    }
    override func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attrs=[kCTFontAttributeName:UIFont.systemFont(ofSize: 15),kCTForegroundColorAttributeName:UIColor.colorWithCustom(r: 0x99, g: 0x99, b: 0x99)]
        return NSAttributedString(string: "暂无设备", attributes: attrs as [NSAttributedStringKey : Any])
    }
    
}

extension DeviceViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "deviceInfocell") as! DeviceInfoCell
        
   
        cell.selectionStyle = .none
        
        if dataList.count > 0 {
            
            cell.deviceInfo = dataList[indexPath.section]
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view  = UIView.init()
        view.backgroundColor = THEME_BG_COLOR
  
        return view
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        deviceInfo = dataList[indexPath.section]
        
        showPwdAlertView()
        

    }
    
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      
        let alert = UIAlertController.init(title:
            "删除该设备？", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        
        let firstAction = UIAlertAction.init(title: "确定", style: .default) { (nil) in
            
            self.viewModel.deleteDevice(deviceID: self.deviceInfo.deviceId, userID: String(UserSettings.shareInstance.getUserID()!)) {
                
                Utils.showHUD(info: "设备已删除")
                    NotificationCenter.default.post(name: NOTIFY_HOMEVC_REFRESH, object: self)
                self.dataList.remove(at: indexPath.section)
                tableView.reloadData()
            }
            
        }
        alert.addAction(cancelAction)
        alert.addAction(firstAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "解绑"
    }
    
    
    
}

extension DeviceViewController:PasswordAlertViewDelegate {
    
    func passwordCompleteInAlertView(alertView: PasswordAlertView, password: String) {
        
        alertView.removeFromSuperview()
        
      
        
        self.viewModel.ckeckLockPassword(deviceID: deviceInfo.deviceId, masterPassword: password) {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ManagerDeviceVC") as! ManagerDeviceViewController
            vc.deviceID = self.deviceInfo.deviceId
            vc.deviceInfo = self.deviceInfo
            vc.userPwd = password
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}





