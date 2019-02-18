//
//  ManagerDetailViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/16.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit
import ObjectMapper


class ManagerDetailViewController: ThemeViewController {
    
    
  
    
    @IBOutlet weak var nameView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pwdLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!

    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    var detailType = 1
    var recordInfo:RecondListInfo!
    fileprivate var viewModel = ManagerDetailViewModel()
    
    
    
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
extension ManagerDetailViewController{
    
    
    func setupUI(){
        
        
        nameLabel.text = recordInfo.name
        
        
        if recordInfo.passId != nil {
            
            if recordInfo.passId >= 1 && recordInfo.passId <= 30 {
                
                typeLabel.text = "管理员"
            }else {
                
                typeLabel.text = "普通用户"
            }
        }
        
        if recordInfo.role != nil {
            
            typeLabel.text = (recordInfo.role == 0) ? "管理员":"普通用户"
        }
        
        

       timeLabel.text = recordInfo.createTime
        
        if detailType == 1 {
            
            titleLabel.text = "密码"
            detailLabel.text = recordInfo.password
        }else if  detailType == 4 {
            
            titleLabel.text = "手机号"
            detailLabel.text = recordInfo.mobile
            
           
        }else{
            
            titleLabel.text = "ID"
            detailLabel.text = String(recordInfo.recordID)
            
        }
        
        
        let webSocket = KMWebSocket.sharedInstance()
        webSocket.webSocketDelegate = self
        
        
        
        nameView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAlertView)))
      

    }
    
    @objc func showAlertView(){
        
        let pswAlertView = KWAlertView.init(frame: self.view.bounds)
        let label = pswAlertView.BGView.viewWithTag(10) as! UILabel
        label.text = "修改名称"
        pswAlertView.delegate = self
        self.view.addSubview(pswAlertView)
        
        
    }
    
}

extension ManagerDetailViewController:KWAlertViewDelegate {
    
    func passwordCompleteInAlertView(alertView: KWAlertView, name: String) {
        
        alertView.removeFromSuperview()
        
        self.viewModel.updateName(name: name, passID: self.recordInfo.recordID) {
            
            Utils.showHUD(info: "修改成功")
            self.nameLabel.text = name
            let vc = self.navigationController?.viewControllers[2] as? ManagerPWDViewController
            vc?.isRefresh = true
            self.navigationController?.popViewController(animated: true)
        }
    }
}


extension ManagerDetailViewController:KMWebSocketDelegate{
    
    
    func websocketDidReceiveMessage(socket: KMWebSocket, text: String) {
        
    
        if let result = CommonResult<BaseMappable>(JSONString:text){
            
            Utils.showHUD(info: result.message)
           let vc = self.navigationController?.viewControllers[2] as? ManagerPWDViewController
            vc?.isRefresh = true
        }
        
        navigationController?.popViewController(animated: true)
        
    }
}

