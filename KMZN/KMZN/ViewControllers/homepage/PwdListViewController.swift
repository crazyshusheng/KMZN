//
//  PwdListViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/10/11.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit
import MJRefresh

class PwdListViewController: ThemeViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var deviceID = ""
    
    var masterPwd = ""
    
    var dataList = [TemporaryPwdInfo]()
    
    var isRefresh = false
    
    var viewModel = TemporaryPWDViewModel()
    var managerModel = ManagerDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getInfoList()
      
        
           self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "+添加"), style: .plain, target: self, action: #selector(addPassword))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if isRefresh{
            
            getInfoList()
            isRefresh = false
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
extension PwdListViewController{
    
    
    func setupUI(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        self.navigationItem.title = "临时密码"
        
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(getInfoList))
        tableView.mj_header = header
    }
    
    @objc func getInfoList(){
        
        viewModel.getTemporaryPasswordList(deviceId: deviceID, temporaryType: nil) {
            
            self.dataList = self.viewModel.recordList.reversed()
            self.tableView.reloadData()
            self.tableView.mj_header.state = .idle
        }
        
    }
    
    
    @objc func addPassword(){
        
        
        let vc  = storyboard?.instantiateViewController(withIdentifier: "TemporaryPwdVC")  as! TemporaryPwdViewController
        vc.deviceID = self.deviceID
        vc.lockPwd = masterPwd
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func sharePwdWithType(type:SSDKPlatformType,dataInfo:TemporaryPwdInfo){
        
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
    
    
}
extension PwdListViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pwd_list_cell")
        
        if dataList.count > 0 {
            
            let info = dataList[indexPath.row]
            let nameLabel  = cell?.viewWithTag(10) as! UILabel
            let categoryLabel = cell?.viewWithTag(11) as! UILabel
            let timeLabel = cell?.viewWithTag(12) as! UILabel
            
            if info.temporaryType == 0 {
                
                categoryLabel.text = "一次性密码"
            }else {
                
                categoryLabel.text = "时间段密码"
            }
            if info.name == "" {
                
                nameLabel.text = "临时密码"
            }else{
                
                nameLabel.text = info.name
            }
            
            timeLabel.text = info.createTime
           
        }
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataList.count
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            let detailView = Bundle.main.loadNibNamed("temporaryPwdView", owner: nil, options: nil)!.first as! TemporaryPwdView
            detailView.info = dataList[indexPath.row]
            detailView.delegate = self
            self.view.addSubview(detailView)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController.init(title:
           "确定要删除密码?", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        
        let firstAction = UIAlertAction.init(title: "确定", style: .default) { (nil) in
           
            
            self.managerModel.deletePasswordRecord(recordId: self.dataList[indexPath.row].reocrdId,deviceId: self.dataList[indexPath.row].deviceId) {
                
                
                
                self.dataList.remove(at: indexPath.row)
                self.tableView.reloadData()
                
            }
            
           
        }
        alert.addAction(cancelAction)
        alert.addAction(firstAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
}

extension PwdListViewController:TemporaryPwdViewDelegate{
    
    
    func pwdShare(dataInfo: TemporaryPwdInfo, type: String) {
        
        switch type {
        case "wechat":
            sharePwdWithType(type: .typeWechat, dataInfo: dataInfo)
        case "message":
            sharePwdWithType(type: .typeSMS, dataInfo: dataInfo)
        case "copy":
            sharePwdWithType(type: .typeCopy, dataInfo: dataInfo)
        default:
            break
        }
        
        
    }
    
}

