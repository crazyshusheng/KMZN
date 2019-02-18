//
//  DeviceInfoCell.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/9.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class DeviceInfoCell: UITableViewCell {
    
    
    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var stateView: UIImageView!
    
    
    @IBOutlet weak var stateLabel: UILabel!
    
    
    
    
    var deviceInfo: DeviceInfo! {
        
        didSet{
            
           infoLabel.text = deviceInfo.name
            
            if deviceInfo.online == 1{
                
                iconView.image = UIImage.init(named: "锁-正常运行")
                stateView.image = UIImage.init(named: "正常运行-设备")
                stateLabel.text = "正常运行"
                stateLabel.textColor = THEME_COLOR
                
            }else{
                
                iconView.image = UIImage.init(named: "锁-已离线")
                stateView.image = UIImage.init(named: "已离线-设备")
                stateLabel.text = "已离线"
                stateLabel.textColor = THEME_GRAY_COLOR
                
            }
           
          
            
        }
        
        
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
