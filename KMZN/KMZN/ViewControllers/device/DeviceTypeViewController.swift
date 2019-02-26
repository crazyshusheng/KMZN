//
//  DeviceTypeViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/12/17.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class DeviceTypeViewController: ThemeViewController {
    
    @IBOutlet weak var tableView: UITableView!
        
   
    var dataList = ["智能锁"]
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
      
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension DeviceTypeViewController{
    
    
    func setupUI(){
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        
    }
    
}

extension DeviceTypeViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 48
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "device_type_cell")
        
        if dataList.count > 0 {
            
           
            (cell?.viewWithTag(10) as? UILabel)?.text =  dataList[indexPath.row]
        }
        
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataList.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let addDeviceVC = storyboard?.instantiateViewController(withIdentifier: "TypeDeviceVC") as! TypeDeviceViewController
       
        navigationController?.pushViewController(addDeviceVC, animated: true)
        
        
    }
    
    
}

