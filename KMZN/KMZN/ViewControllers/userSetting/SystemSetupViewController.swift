//
//  SystemSetupViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/9/10.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class SystemSetupViewController: ThemeViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let titles = [["消息推送"],["清理缓存"]]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SystemSetupViewController {
    
    func setupUI(){
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
    }
    
}



extension SystemSetupViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "setting_Cell")
        
        (cell?.viewWithTag(10) as! UILabel).text = titles[indexPath.section][indexPath.row]
        
        let detailLabel = cell?.viewWithTag(11) as! UILabel
        
        switch (indexPath.section,indexPath.row ){
            
        case (0,0):
            
            if  UIApplication.shared.currentUserNotificationSettings?.types.rawValue == 0 {
                
                detailLabel.text = "已关闭，去设置中打开"
                
            }else{
                
                detailLabel.text = "已打开"
            }
        case (1,0):
            
           detailLabel.text = Utils.fileSizeOfCache() + "M"
            
            

        default:
            break
        }
        
        
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return 1
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section,indexPath.row) {
            
        case (0,0):
            
            if  UIApplication.shared.currentUserNotificationSettings?.types.rawValue == 0 {
                
                let settingUrl = URL(string: UIApplicationOpenSettingsURLString)!
                if UIApplication.shared.canOpenURL(settingUrl)
                {
                    UIApplication.shared.openURL(settingUrl)
                }
            }
            tableView.reloadData()
            
        case (1,0):
            
            Utils.clearCache()
          
            Utils.showHUD(info: "缓存已清理")
            
            tableView.reloadData()
            
        default:
            break
        }
       

    }
    
    
}

