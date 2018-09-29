//
//  TemporaryPwdViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/9.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class TemporaryPwdViewController: ThemeViewController {
    

    @IBOutlet weak var pwdView: UIView!
    
    var textField:UITextField!
    
    var pwdLabelArray = NSMutableArray.init()
    
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

extension TemporaryPwdViewController{
    
    func setupUI(){
        
        
        pwdView.layer.cornerRadius = 12
        pwdView.layer.borderWidth = 0.6
        pwdView.layer.borderColor = UIColor.gray.cgColor
        
        for i in 0 ..< 6 {
            
            let pswLabel = UILabel.init(frame: CGRect.init(x: Int(pwdView.frame.size.width)/6 * i, y: 0, width: Int(pwdView.frame.size.width)/6, height: Int(pwdView.frame.size.height)))
            pswLabel.textAlignment = .center
            pswLabel.backgroundColor = UIColor.clear
            pswLabel.isUserInteractionEnabled = true
            pwdLabelArray.add(pswLabel)
            
            pwdView.addSubview(pswLabel)
            
            
            if i < 5{
                
                let line = UIView.init(frame: CGRect.init(x: Int(pwdView.frame.size.width)/6 * (i + 1), y: 0, width: Int(1), height: Int(pwdView.frame.size.height)))
                line.backgroundColor = UIColor.lightGray
                pwdView.addSubview(line)
                
            }
        }
        
        let textFiled = UITextField.init(frame: pwdView.frame)
        textFiled.backgroundColor = UIColor.clear
        //设置代理
        textFiled.delegate = self
        //监听编辑状态的变化
        textFiled.addTarget(self, action: #selector(textFiledValueChanged(textField:)), for: .editingChanged)
        textFiled.tintColor = UIColor.clear
        textFiled.textColor = UIColor.clear
        textFiled.becomeFirstResponder()
        //设置键盘类型为数字键盘
        textFiled.keyboardType = .numberPad
        self.textField = textFiled
        pwdView.addSubview(self.textField)
        
        
    }
    
  
    
    @objc func textFiledValueChanged(textField:UITextField) {
        
      
        let pwd = textField.text!
    
        for label in  pwdLabelArray{
        
           
            (label as! UILabel).text = ""
           
        }
        
        for i in 0 ..< Int(pwd.count){
            
            let label = pwdLabelArray[i] as! UILabel
            
            label.text = String(pwd[pwd.index(pwd.startIndex, offsetBy: i)])
        }
        
    
    }
    
    
  
    
 
    
}

extension TemporaryPwdViewController:UITextFieldDelegate{
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.count == 0 {//判断是是否为删除键
            return true
        }else if (textField.text?.count)! >= 6 {
            //当输入的密码大于等于6位后就忽略
            return false
        } else {
            return true
        }
    }
    
}

