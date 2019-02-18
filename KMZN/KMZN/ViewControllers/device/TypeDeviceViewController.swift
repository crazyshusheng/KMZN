//
//  TypeDeviceViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/10.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit
import Kingfisher


class TypeDeviceViewController: ThemeViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataList = [ProductTypeInfo]()
    
    var productViewModel = ProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        productViewModel.getUserDevices {

            self.dataList = self.productViewModel.infoList
            self.tableView.reloadData()
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension TypeDeviceViewController{
    
    
    func setupUI(){
        
        
        tableView.delegate = self
        tableView.dataSource = self
     
        tableView.tableFooterView = UIView()

    }
    
}

extension TypeDeviceViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "type_device_cell")
        
        if dataList.count > 0 {
            
//            let imageView =  cell?.viewWithTag(10) as? UIImageView
            
//            if let image = dataList[indexPath.row].image{
//                
//                 imageView?.kf.setImage(with: URL.init(string:image ))
//            }
            
    
            (cell?.viewWithTag(11) as? UILabel)?.text =  dataList[indexPath.row].modelNumber
        }
        
    
        return cell!
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataList.count
    }
    


    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        let addDeviceVC = storyboard?.instantiateViewController(withIdentifier: "AddDeviceVC") as! AddDeviceViewController
       addDeviceVC.productInfo = self.dataList[indexPath.row]
       navigationController?.pushViewController(addDeviceVC, animated: true)
        
        
    }
    
    
}
