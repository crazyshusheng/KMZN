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
    
    
}




extension UnlockRecordViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "unlockrecord_cell") as! UnlockRecordCell
        
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
