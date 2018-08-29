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
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!

    @IBOutlet weak var deleteButton: UIButton!
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
    

    @IBAction func deleteRecord(_ sender: Any) {
        
        if detailType == 4{
            
            viewModel.deleteUserDevice(deviceId: recordInfo.deviceId, userId: recordInfo.userId) {
                
                
            }
        }else{
            
            viewModel.deletePasswordRecord(recordId: recordInfo.recordID, passId: recordInfo.passId, passType: recordInfo.passType, deviceId: recordInfo.deviceId) {
                
                 
            }
            
        }
        
    }
    

}
extension ManagerDetailViewController{
    
    
    func setupUI(){
        
        nameLabel.text = recordInfo.name
        detailLabel.text = (detailType == 4) ? String(recordInfo.userId) : recordInfo.password
        let webSocket = KMWebSocket.sharedInstance()
        webSocket.webSocketDelegate = self
        
        if recordInfo.role == 0 {
            
            nameView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAlertView)))
            deleteButton.isHidden = false
            
        }else{
            
            deleteButton.isHidden = true
        }
        
      
        
        
        
        
    }
    
    @objc func showAlertView(){
        
        if detailType != 4 {
            
            let pswAlertView = KWAlertView.init(frame: self.view.bounds)
            let label = pswAlertView.BGView.viewWithTag(10) as! UILabel
            label.text = "修改名称"
            pswAlertView.delegate = self
            self.view.addSubview(pswAlertView)
        }
        
        
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

