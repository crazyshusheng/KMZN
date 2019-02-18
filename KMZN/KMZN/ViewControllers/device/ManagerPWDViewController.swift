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
        tableView.emptyDataSetSource = self
        
        
        navigationItem.title = titleName
        
        if deviceInfo.role == 0  &&   typeID == 1 {
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "+添加"), style: .plain, target: self, action: #selector(addRecord))
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
        
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "manager_pwd_cell") as! DeviceManagerCell
        if dataList.count > 0 {
            
            cell.type = self.typeID
            cell.managerInfo = dataList[indexPath.section]
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
        view.frame = CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 10)
        
        return view
    }

    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ManagerDetailVC") as! ManagerDetailViewController
        vc.detailType = listType
        vc.recordInfo = dataList[indexPath.section]
        navigationController?.pushViewController(vc, animated: true)
        
    
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        if deviceInfo.role == 0 {
            
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
            "确定要删除密码?", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        
        let firstAction = UIAlertAction.init(title: "确定", style: .default) { (nil) in
            
        self.viewModel.deletePasswordRecord(recordId:self.dataList[indexPath.section].recordID,deviceId:self.dataList[indexPath.section].deviceId) {
            
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

