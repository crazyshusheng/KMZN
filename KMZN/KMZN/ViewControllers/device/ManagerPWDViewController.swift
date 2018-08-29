//
//  ManagerPWDViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/11.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class ManagerPWDViewController: ThemeViewController {

    @IBOutlet weak var tableView: UITableView!
    var titleName:String?
    var typeID:Int!
    var deviceInfo:DeviceInfo!
    var dataList = [RecondListInfo]()
    var listType = 1
    var isRefresh = false
    
    fileprivate var viewModel = RecordListViewModel.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupUI()
        getInfoList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if isRefresh{
             getInfoList()
             isRefresh = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ManagerPWDViewController{
    
    
    func setupUI(){
    
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        navigationItem.title = titleName
        
        if deviceInfo.role == 0 {
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "添加设备"), style: .plain, target: self, action: #selector(addRecord))
        }
    }
    
    func getInfoList(){
        
        switch typeID {
            
        case 1,2,3:
            if typeID == 2 {
                
                listType = 3
            }else if typeID == 3 {
                
                listType = 2
            }
            viewModel.getDeviceInfo(deviceID: deviceInfo.deviceId, passType: String(listType)) {
                
                self.dataList =  self.viewModel.recordList
                self.tableView.reloadData()
            }
        case  4:
            
            listType = 4
            viewModel.getDeviceUsers(deviceID: deviceInfo.deviceId) {
                
                self.dataList =  self.viewModel.recordList
                self.tableView.reloadData()
            }
            
        default:
            break
        }
    }
    
    @objc func addRecord(){
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddPwdVC") as! AddPwdViewController
        vc.type = listType
        vc.deviceID = self.deviceInfo.deviceId
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

extension ManagerPWDViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "manager_pwd_cell") as! DeviceManagerCell
        if dataList.count > 0 {
            
            cell.type = self.typeID
            cell.managerInfo = dataList[indexPath.row]
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataList.count
        
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
  
        let vc = storyboard?.instantiateViewController(withIdentifier: "ManagerDetailVC") as! ManagerDetailViewController
        vc.detailType = listType
        vc.recordInfo = dataList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    
    }
    
    
}

