//
//  UserViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/13.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class UserViewController: BasicViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var photoButton: UIButton!
    
    private let titles = ["用户设置","通知消息","系统设置","当前版本","关于我们"]
    
    
    
    //[["通知消息"],["系统设置","检查更新"],["关于我们"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUserVC), name: NOTIFY_USERVC_DEVICE, object: nil)
    }
    
    
    
    @IBAction func setUserInfo(_ sender: Any) {
        
        let setVC = storyboard?.instantiateViewController(withIdentifier: "SettingUserVC") as! SettingUserViewController
        navigationController?.pushViewController(setVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension UserViewController{
    
    
    func setupUI(){
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
    }
    
    func loadData(){
        
        if UserSettings.shareInstance.isLogin(){
            
            if let nickname = UserSettings.shareInstance.getStringValue(key: UserSettings.USER_NICK_NAME) {
                
                if nickname.count > 0 {
                    
                    nameLabel.text = nickname
                }
            }else{
                
                 nameLabel.text = UserSettings.shareInstance.getStringValue(key: UserSettings.USER_PHONE)
            }
          
            
            if let photo =  UserSettings.shareInstance.getStringValue(key: UserSettings.USER_PHOTO){
                print(photo)
                self.photoButton.kf.setImage(with: URL.init(string: photo), for: .normal)
            }else{
                
                self.photoButton.setImage(#imageLiteral(resourceName: "我的-默认头像"), for: .normal)
            }
        }
        
    }
    
    
    
    @objc func refreshUserVC(){
    
         loadData()
    }
    
    
    
    
}

extension UserViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 48
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "cellID"
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: cellID)
        
        cell.textLabel?.text = titles[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.imageView?.image = UIImage.init(named: titles[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        
        if indexPath.row == 3 {
            
           
            let versionStr =  Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String?
            cell.detailTextLabel?.text = "V" + versionStr!
            
        }else{
            
            cell.detailTextLabel?.text = ""
        }
        
        
        //去掉最后一个cell的分割线
        if indexPath.row == titles.count - 1{
            
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, UIScreen.main.bounds.size.width)
        }else{
            
            cell.separatorInset =  UIEdgeInsetsMake(0, 15, 0, 0)
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titles.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        switch  (indexPath.row) {
            
        case 0:
            
            
            let setVC = storyboard?.instantiateViewController(withIdentifier: "SettingUserVC") as! SettingUserViewController
            navigationController?.pushViewController(setVC, animated: true)
        
        case 1:
            
            let aboutVC = storyboard?.instantiateViewController(withIdentifier: "MessageVC") as! MessageViewController
            navigationController?.pushViewController(aboutVC, animated: true)
        case 2:
            
            
            let aboutVC = storyboard?.instantiateViewController(withIdentifier: "SystemSetupVC") as! SystemSetupViewController
            navigationController?.pushViewController(aboutVC, animated: true)
            
         
        case 3:
                break
            
        case 4:
            
            let aboutVC = storyboard?.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsViewController
            navigationController?.pushViewController(aboutVC, animated: true)
            
            
        default:
            break
        }
    
    }
}

