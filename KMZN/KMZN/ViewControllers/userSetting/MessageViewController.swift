//
//  MessageViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/10/24.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class MessageViewController: ThemeViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var viewModel = MessageViewModel()
    
    fileprivate var dataList = [MessageInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getMessagePushRecord{
            
            self.dataList = self.viewModel.messageList
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension MessageViewController {
    
    func setupUI(){
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetSource = self
    }
    
}



extension MessageViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "message_cell") as! MessageListCell
        
        cell.selectionStyle = .none
        
        if dataList.count > 0 {
            
            cell.messageInfo = dataList[indexPath.row]
        }
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataList.count
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel.getMessageDetail(recordId: dataList[indexPath.row].recordId) {
            
            self.dataList[indexPath.row].isCheck = "Y"
            let indexpath = IndexPath.init(row: indexPath.row, section: indexPath.section)
            self.tableView.reloadRows(at: [indexpath], with: .automatic)
        }
        
    }
    
}

