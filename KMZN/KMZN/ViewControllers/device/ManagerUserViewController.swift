//
//  ManagerUserViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/12/17.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class ManagerUserViewController: ThemeViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
     var info:DeviceInfo!
    
      var dataList = [RecondListInfo]()
    
    fileprivate var viewModel = RecordListViewModel.init()
    
     var isRefresh = false

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
extension ManagerUserViewController{
    
    
    func setupUI(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetSource = self
        
        
      
        if info.role == 0 {
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "+添加"), style: .plain, target: self, action: #selector(addRecord))
            
            
        }
        
        
     
       
        
    }
    
    func getInfoList(){
        
        viewModel.getDeviceUsers(deviceID: info.deviceId) {
            
            self.dataList = self.viewModel.recordList
            self.tableView.reloadData()
        }
    }
    
    @objc func addRecord(){
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddPwdVC") as! AddPwdViewController
        vc.type = 4
        vc.deviceID = self.info.deviceId
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

extension ManagerUserViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "manager_user_cell") as! ManagerUserCell
        if dataList.count > 0 {
            
            cell.managerInfo = dataList[indexPath.row]
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataList.count
        
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ManagerDetailVC") as! ManagerDetailViewController
        vc.detailType = 4
        vc.recordInfo = dataList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        if info.role == 0 {
            
            return UITableViewCellEditingStyle.delete
        }else{
            
            return UITableViewCellEditingStyle.none
        }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController.init(title:
            "确定要删除用户?", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        
        let firstAction = UIAlertAction.init(title: "确定", style: .default) { (nil) in
            
            self.viewModel.deleteUserDevice(deviceId:self.dataList[indexPath.row].deviceId,userId:self.dataList[indexPath.row].userId) {
                
                self.dataList.remove(at: indexPath.row)
                self.tableView.reloadData()
                
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(firstAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    
    
}



