//
//  SettingUserViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/13.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class SettingUserViewController: ThemeViewController {


    @IBOutlet weak var tableView: UITableView!
    
    private let titles = [["用户名"],["手机号","密码修改"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
          setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOut(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        navigationController?.pushViewController(loginVC, animated: true)
        
    }
    


}


extension SettingUserViewController{
    
    
    func setupUI(){
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        
    }
    
}

extension SettingUserViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init()
        
        cell.textLabel?.text = titles[indexPath.section][indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        
        cell.accessoryType = .disclosureIndicator
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 2
       
        default:
            return 0
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     
        
    }
    
    
}


