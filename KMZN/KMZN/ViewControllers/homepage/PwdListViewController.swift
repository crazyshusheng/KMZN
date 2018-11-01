//
//  PwdListViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/10/11.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class PwdListViewController: ThemeViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var deviceID = ""
    
    var dataList = [TemporaryPwdInfo]()
    
    var viewModel = TemporaryPWDViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getTemporaryPasswordList(deviceId: deviceID, temporaryType: nil) {
            
            self.dataList = self.viewModel.recordList.reversed()
            self.tableView.reloadData()
        }
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
extension PwdListViewController{
    
    
    func setupUI(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetSource = self
    }
    
}
extension PwdListViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pwd_list_cell")
        
        if dataList.count > 0 {
            
            let info = dataList[indexPath.row]
            let nameLabel  = cell?.viewWithTag(10) as! UILabel
            let timeLabel = cell?.viewWithTag(11) as! UILabel
            
            if info.temporaryType == 0 {
                
                nameLabel.text = "一次性密码"
            }else {
                
                nameLabel.text = info.name
            }
            
            timeLabel.text = info.createTime
           
        }
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataList.count
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "PwdDetailVC") as! PwdDetailViewController
       
        vc.dataInfo = dataList[indexPath.row]
  
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
}
