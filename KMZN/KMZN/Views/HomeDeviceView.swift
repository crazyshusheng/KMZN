//
//  HomeDeviceView.swift
//  KMZN
//
//  Created by 陈志超 on 2018/12/14.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class HomeDeviceView: UIView {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var deviceView: UIImageView!
    
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    

    @IBOutlet weak var battery: UIImageView!
    
    @IBOutlet weak var signal: UIImageView!
    
    @IBOutlet weak var leftView: UIImageView!
    
    @IBOutlet weak var rightView: UIImageView!
    
    
    
    var deviceInfo: DeviceInfo! {
        
        
        didSet{
            
            nameLabel.text = deviceInfo.name
            
            if let name =  UserSettings.shareInstance.getStringValue(key: UserSettings.USER_NICK_NAME) {
                
                welcomeLabel.text = "欢迎回家，" + name
            }else{
                
                welcomeLabel.text = "欢迎回家"
            }
            stateLabel.text = (deviceInfo.online == 1) ? "正常运行" : "已离线"
            
            if deviceInfo.online == 1 {
                
                deviceView.image = #imageLiteral(resourceName: "首页大门锁-正常运行")
            }else {
                
                deviceView.image = #imageLiteral(resourceName: "首页大门锁-已离线")
            }
            
            categoryLabel.text = deviceInfo.modelNumber
            
            if let bat = deviceInfo.battery {
                
                var type = 0
                
                if bat ==  0 {
                    
                    type = 0
                    
                }else if bat >= 1 && bat <= 33{
                    
                    type = 1
                }else if bat >= 34 && bat <= 66{
                    
                    type = 2
                }else if bat >= 67 && bat <= 100{
                    
                    type = 3
                }
                let name = "电量" + String(type)
                
                battery.image = UIImage.init(named: name)
                
            }
            if let sign = deviceInfo.signal {
                
                
                var  type = 0
                
                if sign > 0 && sign <= 6 {
                    
                    type = 1
                    
                }else if sign >= 7 && sign <= 9 {
                    
                    type = 2
                }else if sign >= 10 && sign <= 12 {
                    
                    type = 3
                }else if sign >= 13 && sign <= 15 {
                    
                    type = 4
                    
                }else if sign >= 16 && sign <= 98 {
                    
                    type = 5
                    
                }else  {
                    
                    type = 0
                    
                }
                
            
                let name = "信号5档" + String(type)
                
                print(name)
                
                signal.image = UIImage.init(named: name)
            }
           
            
       
        }
        
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
    }
    
    
    func setupUI(){
        
        
        
    }
    
    
}
