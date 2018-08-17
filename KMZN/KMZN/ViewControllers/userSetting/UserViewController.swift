//
//  UserViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/13.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let titles = [["通知消息"],["系统设置","检查更新"],["关于我们"]]
    
    @IBOutlet weak var userBtn: UIButton!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    

    @IBAction func login(_ sender: Any) {
        
        if !UserSettings.shareInstance.isLogin(){
            
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
            navigationController?.pushViewController(loginVC, animated: true)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension UserViewController{
    
    
    func setupUI(){
        
        if UserSettings.shareInstance.isLogin(){
            userBtn.setTitle(UserSettings.shareInstance.getStringValue(key: UserSettings.USER_PHONE), for: .normal)
                tipLabel.isHidden = true
        }else{
            
            userBtn.setTitle("登录", for: .normal)
            tipLabel.isHidden = false
        }
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
       
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
        
      
        
        
        
        
    }
    
    
}

