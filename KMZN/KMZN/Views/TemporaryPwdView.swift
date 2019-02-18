//
//  TemporaryPwdView.swift
//  KMZN
//
//  Created by 陈志超 on 2018/12/15.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit



protocol TemporaryPwdViewDelegate:NSObjectProtocol {
    
    func pwdShare(dataInfo: TemporaryPwdInfo,type:String)
}


class TemporaryPwdView: UIView {
    
    

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var pwdLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var availableLabel: UILabel!
    
    
    
    weak var delegate:TemporaryPwdViewDelegate?
    
    
    
    var info:TemporaryPwdInfo!{
        
        
        didSet{
            
            
            if info.name == "" {
                
                nameLabel.text = "临时密码"
            }else{
                
                nameLabel.text = info.name
            }
            
            timeLabel.text = info.createTime
            
            pwdLabel.text = info.password
            
            
        
            if info.temporaryType == 0 {
                
                categoryLabel.text = "一次性密码"
                availableLabel.text = "十分钟"
            }else {
                
                categoryLabel.text = "时间段密码"
                
                
                guard info.repeatWeek != nil  else{
                    
                    return
                }
                
                
                var weekarr = [String]()
                
                for (index,char)  in String(info.repeatWeek.reversed()).enumerated() {
                    
                    if char == "1"{
                        
                        weekarr.append(String(index + 1))
                    }
                }
                
                let weakTime = "(" + info.passwordBeginTime + "~" + info.passwordEndTime + ")"
                availableLabel.text  = "星期" +  weekarr.joined(separator: "、") + weakTime
                
                
            }
            
        }
    }
    
    
    
    
    
    
    
    
    @IBAction func cancelView(_ sender: Any) {
        
        self.removeFromSuperview()
    }
    
    @IBAction func shareToWeChat(_ sender: Any) {
        
        
        delegate?.pwdShare(dataInfo:info, type: "wechat")
    }
    
    @IBAction func shareToMessage(_ sender: Any) {
        
        delegate?.pwdShare(dataInfo: info, type: "message")
    }
    
    
    @IBAction func copyPwd(_ sender: Any) {
        
          delegate?.pwdShare(dataInfo: info, type: "copy")
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
     
    }
    
    
    
    func setupUI(){
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    
}
