//
//  PwdDetailViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/10/11.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class PwdDetailViewController: ThemeViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pwdLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var dataInfo = TemporaryPwdInfo()
    
    fileprivate var viewModel = ManagerDetailViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
        // Do any additional setup after loading the view.
    }

    @IBAction func deletePwd(_ sender: Any) {
        
        viewModel.deletePasswordRecord(recordId: dataInfo.reocrdId,deviceId: dataInfo.deviceId) {
            
            Utils.showHUD(info: "命令下发成功")
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func sharetowechat(_ sender: Any) {
        
        sharePwdWithType(type: .typeWechat)
    }
    
    @IBAction func sharetomessage(_ sender: Any) {
        
       sharePwdWithType(type: .typeSMS)
    }
    
 
    @IBAction func copypwd(_ sender: Any) {
        
       sharePwdWithType(type: .typeCopy)
    }
    
    func sharePwdWithType(type:SSDKPlatformType){
        
        let shareParames = NSMutableDictionary()
        
        if type == .typeWechat {
            
            shareParames.ssdkSetupShareParams(byText: dataInfo.password,
                                              images : UIImage(named: "app_logo.png"),
                                              url : NSURL(string:"www.homehealth.top") as URL?,
                                              title : "临时密码",
                                              type : SSDKContentType.auto)
        }else{
            
             shareParames.ssdkSetupShareParams(byText: dataInfo.password, images: nil, url: nil, title: nil, type: SSDKContentType.auto)
        }
        
        //2.进行分享
        ShareSDK.share(type, parameters: shareParames) { (state, userdata, contentEntity, error) in
            
            switch state
            {
            case .success:
                print("Success")
                
                if type == .typeCopy{
                    
                    Utils.showHUD(info: "复制成功")
                }
            case .fail:
                print("Fail:%@",error ?? "")
            case .cancel:
                print("cancel")
            default : break
            }
        }
        
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PwdDetailViewController{
    
    func setupUI(){
        
        pwdLabel.text = dataInfo.password
        
        if dataInfo.temporaryType == 0 {
            
            nameLabel.text = "一次性密码"
            timeLabel.text = "10分钟"
        }else {
            
            guard dataInfo.repeatWeek != nil  else{
                
               return
            }
            
            nameLabel.text = dataInfo.name
            
            var weekarr = [String]()
            
            for (index,char)  in String(dataInfo.repeatWeek.reversed()).enumerated() {
                
                if char == "1"{
                    
                   weekarr.append(String(index + 1))
                }
            }
            
            let weakTime = "(" + dataInfo.passwordBeginTime + "~" + dataInfo.passwordEndTime + ")"
            timeLabel.text  = "星期" +  weekarr.joined(separator: "、") + weakTime
        }
        
    }
    
}
