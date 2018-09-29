//
//  ThemeViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/9.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit
import DZNEmptyDataSet


class ThemeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        

        //返回按钮颜色
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        
        navigationController?.navigationBar.isTranslucent = false
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.tabBarController?.tabBar.isHidden = true
        
        
    
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false
       
  
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

extension ThemeViewController:DZNEmptyDataSetSource{
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return #imageLiteral(resourceName: "空状态")
    }
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attrs=[kCTFontAttributeName:UIFont.systemFont(ofSize: 15),kCTForegroundColorAttributeName:UIColor.colorWithCustom(r: 0x99, g: 0x99, b: 0x99)]
        return NSAttributedString(string: "暂无记录", attributes: attrs as [NSAttributedStringKey : Any])
    }
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        
        return UIColor.white
    }
    
}



