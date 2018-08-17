//
//  ManagerPWDViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/11.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class ManagerPWDViewController: ThemeViewController {

    @IBOutlet weak var tableView: UITableView!
    var titleName:String?
    
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

extension ManagerPWDViewController{
    
    
    func setupUI(){
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        navigationItem.title = titleName
    }
    
}

extension ManagerPWDViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "manager_pwd_cell")
        
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
  
        let vc = storyboard?.instantiateViewController(withIdentifier: "ManagerDetailVC") as! ManagerDetailViewController
        navigationController?.pushViewController(vc, animated: true)
        
    
    }
    
    
}

