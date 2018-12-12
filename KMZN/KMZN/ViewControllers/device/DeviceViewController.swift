//
//  DeviceViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/10.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class DeviceViewController: BasicViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = DeviceListViewModel()
    
    var dataList = [DeviceInfo]()
    
    var deviceInfo = DeviceInfo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadData()
        
        viewModel.viewController = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshDeviceUI), name: NOTIFY_DEVICEVC_DEVICE, object: nil)
        
     
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addDevice(_ sender: Any) {
        
        
    }
    

}

extension DeviceViewController{
    
    
    func setupUI(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "DeviceInfoCell", bundle: nil), forCellReuseIdentifier: KMDeviceCellID)
        tableView.separatorStyle = .none //去掉cell的分界线
        tableView.emptyDataSetSource = self
    
    }
    
    func loadData(){
        
        viewModel.getUserDevices(isSort: false, finishedCallback: {
          
            self.dataList = self.viewModel.infoList
            self.tableView.reloadData()
        })
    }
    
    @objc func refreshDeviceUI(){
        
         loadData()
    }
    
    
    func showPwdAlertView(){
        
        let alertView = PasswordAlertView.init(frame: self.view.bounds)
        let label = alertView.BGView.viewWithTag(10) as! UILabel
        alertView.delegate = self
        label.text = "验证管理员密码"
        self.view.addSubview(alertView)
    }
    
}

extension DeviceViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KMDeviceCellID) as! DeviceInfoCell
        
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.darkGray.cgColor
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
        view.backgroundColor = UIColor.white
        return view
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        deviceInfo = dataList[indexPath.section]
        
        showPwdAlertView()
        

    }
    
    
}

extension DeviceViewController:PasswordAlertViewDelegate {
    
    func passwordCompleteInAlertView(alertView: PasswordAlertView, password: String) {
        
        alertView.removeFromSuperview()
        
        self.viewModel.checkDeviceMangerPWD(deviceId: deviceInfo.deviceId, masterPassword: password) {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ManagerDeviceVC") as! ManagerDeviceViewController
            vc.deviceID = self.deviceInfo.deviceId
            vc.deviceInfo = self.deviceInfo
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


