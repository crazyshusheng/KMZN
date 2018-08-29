//
//  HeartBeatViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/11.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class HeartBeatViewController: ThemeViewController {
    
    @IBOutlet weak var firstBtn: UIButton!
    
    @IBOutlet weak var seconBtn: UIButton!
    
    fileprivate var viewModel = HeartBeatViewModel()
    
    var deviceInfo:DeviceInfo!
    
    var beatType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func firstBtnClick(_ sender: Any) {
        
        firstBtn.isSelected = !firstBtn.isSelected
        seconBtn.isSelected = !firstBtn.isSelected
    }
    
    @IBAction func secondBtnClick(_ sender: Any) {
        
        seconBtn.isSelected = !seconBtn.isSelected
        firstBtn.isSelected = !seconBtn.isSelected
    }
    
    
    @IBAction func confirm(_ sender: Any) {
        
        beatType =  (firstBtn.isSelected) ? 0 : 1
        
        viewModel.setHeartBeat(deviceId: deviceInfo.deviceId, heartBeat: beatType) {
            
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
