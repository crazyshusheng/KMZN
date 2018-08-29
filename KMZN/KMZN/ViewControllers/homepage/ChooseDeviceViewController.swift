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
    
    
    var viewModel = DeviceListViewModel()
    var dataList = [DeviceInfo]()
    
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
        
        
        viewModel.getUserDevices(isSort: true, finishedCallback: {
            
            self.dataList = self.viewModel.infoList
            self.tableView.reloadData()
        })
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
        
        if dataList.count > 0 {
            
            cell.deviceInfo = dataList[indexPath.section]
        }

        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
     
       return 1
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataList.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 || section == 1{
            
             return 40
        }else{
            
            return 5
        }
        
       
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
        
        guard  indexPath.section != 0 else {
            
            return
        }
        
        let alert = UIAlertController.init(title:
            "切换到" + dataList[indexPath.section].name , message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        
        let firstAction = UIAlertAction.init(title: "确定", style: .default) { (nil) in
            
            self.viewModel.chooseCurrentDevice(deviceId: self.dataList[indexPath.section].deviceId, finishedCallback: {
                
                NotificationCenter.default.post(name: NOTIFY_HOMEVC_REFRESH, object: nil)
                self.navigationController?.popViewController(animated: true)
            })
            
        }
        
        alert.addAction(cancelAction)
        alert.addAction(firstAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}



