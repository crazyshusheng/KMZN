//
//  UnlockRecordViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/9.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class UnlockRecordViewController: ThemeViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var viewModel = UnlockRecordViewModel()
    
    var dataList = [UnlockTypeInfo]()
    
    var type = 1  // 1,开锁记录  2,报警记录
    var deviceID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getDataList()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if UserSettings.shareInstance.isPush() {
            
          
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image:UIImage.init(named: "返回"), style: .plain, target: self, action: #selector(backToRootVc))
        }else{
            
            self.navigationItem.leftBarButtonItem = nil
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

    


}
extension UnlockRecordViewController {
    
    
    func setupUI(){
        
        if type == 1{
            
            self.navigationItem.title = "开锁记录"
        }else if type == 2{
            navigationItem.title = "报警记录"
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetSource = self
    }
    
    func getDataList(){
        
        viewModel.getLockRecord(deviceID: deviceID,type:type) {
            
            self.dataList = self.viewModel.infoList
            self.tableView.reloadData()
        }
    }
    
    @objc func backToRootVc(){
    
         UserSettings.shareInstance.setValue(key: UserSettings.IS_PUSH, value: false)
         self.dismiss(animated: true, completion: nil)
    }
    
    
}




extension UnlockRecordViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "unlockrecord_cell") as! UnlockRecordCell
        
        cell.selectionStyle = .none
        
        if dataList.count > 0 {
            
            cell.recordInfo = dataList[indexPath.row]
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataList.count
        
    }
   

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
}
