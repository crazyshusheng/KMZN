//
//  CategoryPwdViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/12/15.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class CategoryPwdViewController: ThemeViewController {
    
    
    
    
    
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var secondView: UIView!
    
    var type = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    @IBAction func save(_ sender: Any) {
        
        let vc = self.navigationController?.viewControllers[(navigationController?.viewControllers.count)! - 2] as? TemporaryPwdViewController
        
        vc?.pwdType = type
        
        navigationController?.popViewController(animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CategoryPwdViewController{
    
    func setupUI(){
        
     firstView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectTime(_:))))
    secondView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectTime(_:))))
    
    }
    
    @objc func selectTime(_ tap:UITapGestureRecognizer){
        
         let viewTag = (tap.view?.tag)!
        
        if (type + 20) == viewTag {
            
            return
        }
        
        type = viewTag - 20
        
        if tap.view == firstView {
            
            firstView.viewWithTag(11)?.isHidden = false
            secondView.viewWithTag(11)?.isHidden = true
            
        }else{
            
            firstView.viewWithTag(11)?.isHidden = true
            secondView.viewWithTag(11)?.isHidden = false
            
        }
        
        print(type)
    }
    
}
