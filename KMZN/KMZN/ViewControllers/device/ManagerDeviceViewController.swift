//
//  ManagerDeviceViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/10.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class ManagerDeviceViewController: ThemeViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let titles = ["密码管理","指纹管理","卡片管理","心跳时间","开锁记录","报警记录","设备成员"]
    fileprivate let viewModel = DeviceInfoViewModel.init()
    var deviceID = "39090334"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getDeviceInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ManagerDeviceViewController{
    
    func setupUI(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func getDeviceInfo(){
        
        viewModel.getDeviceInfo(deviceID: deviceID) {
            
        }
    }
    
    
}

extension ManagerDeviceViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    // #MARK: --UICollectionViewDataSource的代理方法
    
    /**
     - returns: Item的宽高
     */
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width:SCREEN_WIDTH/4, height: 100)
    }
    
    /**
     - 该方法是可选方法，默认为1
     - returns: CollectionView中section的个数
     */
    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        return 1
    }
    /**
     - returns: Section中Item的个数
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 7
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "manager_device_cell", for: indexPath)
        (cell.viewWithTag(10) as! UIImageView).image = UIImage.init(named: titles[indexPath.row])
        (cell.viewWithTag(11) as! UILabel).text = titles[indexPath.row]
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        //某个Cell被选择的事件处理
        switch (indexPath.row) {
            
        case 0,1,2,6:
            
            var title:String?
            var type = indexPath.row + 1
            if indexPath.row == 0 {
                title = "密码管理"
            }else if indexPath.row == 1{
                title = "指纹管理"
            }else if indexPath.row == 2{
                title = "卡片管理"
            }else{
                title = "设备成员"
                type = 4
            }
            let managerVC = storyboard?.instantiateViewController(withIdentifier: "ManagerPWDVC") as! ManagerPWDViewController
            managerVC.titleName = title
            managerVC.deviceID = self.deviceID
            managerVC.typeID = type
            navigationController?.pushViewController(managerVC, animated: true)
        case 3:
            let heartVC = storyboard?.instantiateViewController(withIdentifier: "HeartBeatVC") as! HeartBeatViewController
            navigationController?.pushViewController(heartVC, animated: true)
        case 4,5:
            let recordVC = UIStoryboard.init(name: "Homepage", bundle: nil).instantiateViewController(withIdentifier: "UnlockRecordVC") as! UnlockRecordViewController
            recordVC.type = indexPath.row - 3
            recordVC.deviceID = deviceID
            navigationController?.pushViewController(recordVC, animated: true)
            
            
           
        default:
            break
        }
    }
    
}


