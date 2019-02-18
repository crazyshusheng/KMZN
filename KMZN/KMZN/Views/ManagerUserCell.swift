//
//  ManagerUserCell.swift
//  KMZN
//
//  Created by 陈志超 on 2018/12/17.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class ManagerUserCell: UITableViewCell {

  
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    
    
    var managerInfo:RecondListInfo! {
        
        didSet{
            
            if managerInfo.role == 0 {
                
                typeLabel.text = "管理员"
            }else {
                
                typeLabel.text = "普通用户"
            }
            
        
            nameLabel.text = managerInfo.name
            
            if let url = managerInfo.avatar {
                
                 photoView.kf.setImage(with: URL.init(string: url))
            }
            
           
            
            
        }
        
    }
    
    
    
}
