//
//  DeviceManagerCell.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/20.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class DeviceManagerCell: UITableViewCell {

    @IBOutlet weak var headView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var delLabel: UILabel!
    
    @IBOutlet weak var numLabel: UILabel!
    
    
    
    
    
    var  type = 1
    
    var managerInfo:RecondListInfo! {
        
        didSet{
            
            if managerInfo.passId >= 1 && managerInfo.passId <= 30 {
                
                delLabel.text = "管理员"
            }else {
                
                 delLabel.text = "普通用户"
            }
            
           
            
            numLabel.text = "ID:" + String(managerInfo.recordID)
            
             nameLabel.text = managerInfo.name
            
            if type == 1{
                
                headView.image = UIImage.init(named: "password-management")
            }else if type == 2{
                
                 headView.image = UIImage.init(named: "fingerprint-management")
            }else if type == 3{
                
                 headView.image = UIImage.init(named: "card-management")
                
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
