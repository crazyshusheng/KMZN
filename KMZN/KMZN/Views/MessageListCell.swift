//
//  MessageListCell.swift
//  KMZN
//
//  Created by 陈志超 on 2018/11/14.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class MessageListCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    var messageInfo: MessageInfo! {
        
        didSet{
            
            messageLabel.text = messageInfo.message
            
            timeLabel.text = Utils.getDateStr(date: messageInfo.createTime, formatStr: DATE_FORMAT_YYYY_MM_DD_HH_MM)
            
            if messageInfo.isCheck == "N"{
                
                messageLabel.textColor = UIColor.black
            }else {
                
                messageLabel.textColor = UIColor.lightGray
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
