//
//  TemporaryPwdViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/9.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class TemporaryPwdViewController: ThemeViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
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
            pswLabel.textColor = THEME_BG_COLOR
            pswLabel.isUserInteractionEnabled = true
            pwdLabelArray.add(pswLabel)
            
            pwdView.addSubview(pswLabel)
            
            
            if i < 5{
                
                let line = UIView.init(frame: CGRect.init(x: Int(pwdView.frame.size.width)/6 * (i + 1), y: 0, width: Int(1), height: Int(pwdView.frame.size.height)))
                line.backgroundColor = UIColor.lightGray
                pwdView.addSubview(line)
                
            }
        }
        textField = UITextField.init(frame: CGRect.init(x: 0, y: 0, width: pwdView.frame.size.width, height: pwdView.frame.size.height))
        textField.backgroundColor = UIColor.clear
        //设置代理
        textField.delegate = self
        //监听编辑状态的变化
        textField.addTarget(self, action: #selector(textFiledValueChanged(textField:)), for: .editingChanged)
        textField.tintColor = UIColor.white
        textField.textColor = UIColor.white
        textField.becomeFirstResponder()
        
        //设置键盘类型为数字键盘
        textField.keyboardType = .numberPad
        pwdView.addSubview(textField)
        
        
        segmentControl.layer.cornerRadius=20
        segmentControl.tintColor = THEME_BG_COLOR
        
        segmentControl.addTarget(self, action: #selector(selectChange), for: UIControlEvents.valueChanged)
        
    }
    
    @objc func selectChange(){
        
        
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        self.textField.endEditing(true)
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

