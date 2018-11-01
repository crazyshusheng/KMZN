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
    @IBOutlet weak var photoButton: UIButton!
    
    private let titles = [["通知消息"],["系统设置","检查更新"],["关于我们"]]
    
    @IBOutlet weak var userBtn: UIButton!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUserVC), name: NOTIFY_USERVC_DEVICE, object: nil)
    }


    @IBAction func login(_ sender: Any) {
        
        if !UserSettings.shareInstance.isLogin(){
            
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
            navigationController?.pushViewController(loginVC, animated: true)
        }else{
            
            let setVC = storyboard?.instantiateViewController(withIdentifier: "SettingUserVC") as! SettingUserViewController
            navigationController?.pushViewController(setVC, animated: true)
        }
        
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
            
            userBtn.setTitle(UserSettings.shareInstance.getStringValue(key: UserSettings.USER_PHONE), for: .normal)
            
            if let nickname = UserSettings.shareInstance.getStringValue(key: UserSettings.USER_NICK_NAME) {
                
                if nickname.count > 0 {
                    
                    userBtn.setTitle(nickname, for: .normal)
                }
            }
            tipLabel.isHidden = true
            
            if let photo =  UserSettings.shareInstance.getStringValue(key: UserSettings.USER_PHOTO){
                print(photo)
                self.photoButton.kf.setImage(with: URL.init(string: photo), for: .normal)
            }else{
                
                self.photoButton.setImage(#imageLiteral(resourceName: "头像"), for: .normal)
            }
            
        }else{
            userBtn.setTitle("登录", for: .normal)
            tipLabel.isHidden = false
        }
        
    }
    
    
    
    @objc func refreshUserVC(){
    
         loadData()
    }
    
    
    
    
}

extension UserViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init()
        
        cell.textLabel?.text = titles[indexPath.section][indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2 :
            return 1
        default:
            return 0
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        switch  (indexPath.section,indexPath.row) {
            
        case (0,0):
            
            let aboutVC = storyboard?.instantiateViewController(withIdentifier: "MessageVC") as! MessageViewController
            navigationController?.pushViewController(aboutVC, animated: true)
            
        case (1,0):
            
            let aboutVC = storyboard?.instantiateViewController(withIdentifier: "SystemSetupVC") as! SystemSetupViewController
            navigationController?.pushViewController(aboutVC, animated: true)
            
            
        case (2,0):
            
            let aboutVC = storyboard?.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsViewController
            navigationController?.pushViewController(aboutVC, animated: true)
            
        default:
            break
        }
        
        
        
    }
    
    
}

