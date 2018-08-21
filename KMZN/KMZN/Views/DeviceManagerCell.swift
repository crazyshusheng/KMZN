//
//  DeviceManagerCell.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/20.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class DeviceManagerCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var delLabel: UILabel!
    
    var  type = 1
    
    var managerInfo:RecondListInfo! {
        
        didSet{
            
            if type == 4 {
                
                nameLabel.text = managerInfo.name
                delLabel.text = (managerInfo.role == 1) ? "管理员" : "成员"
            }else{
                
                nameLabel.text = managerInfo.name
                delLabel.text = "ID:" + String(managerInfo.recordID)
                
            }
           
            
        }
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
