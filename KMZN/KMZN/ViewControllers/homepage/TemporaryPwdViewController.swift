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
    
    @IBOutlet weak var onetimePwdView: UIView!
    
    @IBOutlet weak var repeatPwdView: UIView!
    
    @IBOutlet weak var startView: UIView!
    
    @IBOutlet weak var endView: UIView!
    
    @IBOutlet weak var weekView: UIView!
    
    var textField:UITextField!
    
    var timeTag = 0
    var startTime = "9:00"
    var endTime = "18:00"
    
    var weekDays=[UIButton]()
    var pwdLabelArray = NSMutableArray.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "记录", style: .plain, target: self, action: #selector(showRecordList))
        // Do any additional setup after loading the view.
    }

    @IBAction func setupPassword(_ sender: Any) {
        
        let vc  = storyboard?.instantiateViewController(withIdentifier: "PwdDetailVC")  as! PwdDetailViewController
        navigationController?.pushViewController(vc, animated: true)
        
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
//        textField.becomeFirstResponder()
        
        //设置键盘类型为数字键盘
        textField.keyboardType = .numberPad
        pwdView.addSubview(textField)
    
        segmentControl.layer.cornerRadius=20
        segmentControl.tintColor = THEME_BG_COLOR
        segmentControl.addTarget(self, action: #selector(selectChange), for: UIControlEvents.valueChanged)
        repeatPwdView.isHidden = true
        
       
        startView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectTime(_:))))
        endView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectTime(_:))))
        setupWeekBtn()
    }
    
    func setupWeekBtn(){
        
        for i in 100...106{
            
            let button = weekView.viewWithTag(i) as! UIButton
            button.backgroundColor = UIColor.white
            button.layer.cornerRadius=15
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.colorWithCustom(r: 0xCC, g: 0xCC, b: 0xCC).cgColor
            button.clipsToBounds = true
            button.setTitleColor(UIColor.colorWithCustom(r: 0x99, g: 0x99, b: 0x99), for: .normal)
            button.setTitleColor(THEME_BG_COLOR, for: .selected)
            
           
            button.addTarget(self, action: #selector(weekDaySelected(sender:)), for: UIControlEvents.touchUpInside)
            weekDays.append(button)
        }
        
    }

    func showTimeView(){
        
        let timeView = TimeSelectView.init(frame: self.view.bounds)
        timeView.delegate = self
        self.view.addSubview(timeView)
        
    }
    
    @objc func weekDaySelected(sender:UIButton){
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            
            sender.layer.borderColor = THEME_BG_COLOR.cgColor
        }else{
            sender.layer.borderColor = UIColor.colorWithCustom(r: 0xCC, g: 0xCC, b: 0xCC).cgColor
            
        }
    }
    
    
    
    @objc func selectChange(){
        
        if segmentControl.selectedSegmentIndex == 0 {
            
            onetimePwdView.isHidden = false
            repeatPwdView.isHidden = true
        }else{
            onetimePwdView.isHidden = true
            repeatPwdView.isHidden = false
        }
    }
    
    @objc func selectTime(_ tap:UITapGestureRecognizer){
        
        showTimeView()
       
        timeTag = (tap.view?.tag)! - 11
    }
    
    @objc func showRecordList(){
        
        let vc  = storyboard?.instantiateViewController(withIdentifier: "PwdListVC")  as! PwdListViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
  
    
    @objc func textFiledValueChanged(textField:UITextField) {
        
       
        let pwd = textField.text!
        
        
        guard  pwd.count <= 6 else {
            
            return
        }
    
        for label in  pwdLabelArray{
        
            (label as! UILabel).text = ""
           
        }
        
        for i in 0 ..< Int(pwd.count){
            
            let label = pwdLabelArray[i] as! UILabel
            
            label.text = String(pwd[pwd.index(pwd.startIndex, offsetBy: i)])
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        self.view.endEditing(true)
    }
    
}

extension TemporaryPwdViewController:TimeSelectViewDelegate{
    
    func timeSelectCompleteInAlertView(alertView: TimeSelectView, time: String) {
        
        print(time)
        var label = UILabel()
        
        alertView.removeFromSuperview()
        
        if timeTag == 0 {
            
            startTime = time
            
            label = (startView.viewWithTag(21)) as! UILabel
        }else {
            endTime = time
            label = (endView.viewWithTag(31)) as! UILabel
        }
        label.text = time
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

