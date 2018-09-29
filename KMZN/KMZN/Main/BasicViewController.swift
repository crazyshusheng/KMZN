//
//  BasicViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/29.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class BasicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


extension BasicViewController:DZNEmptyDataSetSource{
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return #imageLiteral(resourceName: "空设备")
    }
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attrs=[kCTFontAttributeName:UIFont.systemFont(ofSize: 15),kCTForegroundColorAttributeName:UIColor.colorWithCustom(r: 0x99, g: 0x99, b: 0x99)]
        return NSAttributedString(string: "暂无记录", attributes: attrs as [NSAttributedStringKey : Any])
    }
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        
        return UIColor.white
    }
    
}
