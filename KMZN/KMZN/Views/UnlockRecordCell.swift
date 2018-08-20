//
//  UnlockRecordCell.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/9.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class UnlockRecordCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var detLael: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    
    var recordInfo: UnlockTypeInfo! {
        
        didSet{
            
            nameLabel.text = String(recordInfo.recondID)
            timeLabel.text = recordInfo.time
            
            if recordInfo.operateType != nil {
                
                detLael.text = UNLOCK_TYPE[String(recordInfo.operateType)]
            }
            if recordInfo.alertType != nil {
                
                 detLael.text = ALERT_TYPE[String(recordInfo.alertType)]
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
