//
//  ChooseDeviceViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/9.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit


let KMDeviceCellID = "deviceInfocell"

class ChooseDeviceViewController: ThemeViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
     
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupUI(){
        
        self.navigationItem.title = "切换设备"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "DeviceInfoCell", bundle: nil), forCellReuseIdentifier: KMDeviceCellID)
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }

}

extension ChooseDeviceViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KMDeviceCellID) as! DeviceInfoCell
        
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.selectionStyle = .none
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return 1
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view=UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        view.backgroundColor=UIColor.white
        let headView=UILabel(frame: CGRect(x: 10, y: 0, width: SCREEN_WIDTH-10, height: 40))
        headView.textColor=UIColor.colorWithCustom(r: 0x99, g: 0x99, b: 0x99)
        headView.font=UIFont.systemFont(ofSize: 15)
        
        if section == 0 {
            headView.text = "当前选择"
        }else if section == 1 {
            headView.text = "可选设备"
        }else{
            headView.text = ""
        }
        view.addSubview(headView)
        return view
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        
        
    }
    
    
}



