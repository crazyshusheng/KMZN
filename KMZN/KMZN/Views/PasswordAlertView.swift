//
//  PasswordAlertView.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/9.
//  Copyright © 2018年 czc. All rights reserved.
//



import UIKit

protocol PasswordAlertViewDelegate:NSObjectProtocol{
    func passwordCompleteInAlertView(alertView:PasswordAlertView, password:String)
}

class PasswordAlertView: UIView,UITextFieldDelegate {

    let ScreenH = UIScreen.main.bounds.size.height
    let ScreenW = UIScreen.main.bounds.size.width
    let buttonH = 44
    let borderH = 44
    let borderW = 15
    let pointSize = CGSize.init(width: 12, height: 12)
    let pointCount = 10
    var pointViewArray = NSMutableArray.init()
    var labelArray = NSMutableArray.init()
    var BGView = UIView.init()
    var textFiled = UITextField()
    var eyeBtn = UIButton()
   
    let buttonColor = UIColor(red:0.19, green:0.67, blue:0.91, alpha:1.00)
    
    
    weak var delegate:PasswordAlertViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    func setupUI() {
        //背景颜色
        self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        //弹框背景
        let bgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW - 30, height: 200))
        bgView.center = self.center
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 10
        bgView.layer.masksToBounds = true
        BGView = bgView
        let bgViewW = bgView.frame.size.width
        let bgViewH = bgView.frame.size.height
        
        //tipsLabel
        let tipLabel = UILabel.init(frame: CGRect.init(x: 0, y: 20, width: bgViewW, height: 20))
        tipLabel.tag = 10
        tipLabel.text = "请输入管理员密码"
        tipLabel.font = UIFont.systemFont(ofSize: 16)
        tipLabel.textAlignment = NSTextAlignment.center
        bgView.addSubview(tipLabel)
        
        //line
        eyeBtn = UIButton.init(frame: CGRect.init(x: bgView.frame.size.width - 35, y: tipLabel.frame.size.height , width: 20, height: 20))
        eyeBtn.setImage(UIImage.init(named: "密码隐藏"), for: .normal)
        eyeBtn.setImage(UIImage.init(named: "密码显示"), for: .selected)
        eyeBtn.addTarget(self, action: #selector(showAndHiddlePwd(sender:)), for: .touchUpInside)
        
        bgView.addSubview(eyeBtn)
        
        let pwdView = UIView.init(frame: CGRect.init(x:15 , y: Int(tipLabel.frame.origin.y + 45), width: Int(bgView.frame.size.width) - borderW * 2, height: borderH))
        pwdView.layer.cornerRadius = 12
        pwdView.layer.borderWidth = 0.6
        pwdView.layer.borderColor = UIColor.gray.cgColor
        bgView.addSubview(pwdView)
        
        //密码框
        for i in 0..<pointCount {
       
            let pswLabel = UILabel.init(frame: CGRect.init(x: Int(pwdView.frame.size.width)/pointCount * i, y: 0, width: Int(pwdView.frame.size.width)/pointCount, height: Int(pwdView.frame.size.height)))
            pswLabel.textAlignment = .center
            pswLabel.backgroundColor = UIColor.clear
            let pointView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: pointSize.width, height: pointSize.height))
            pointView.center = pswLabel.center
            pointView.backgroundColor = UIColor.black
            pointView.layer.cornerRadius = pointSize.width/2
            pointView.layer.masksToBounds = true
            pointView.isHidden = true
            pwdView.addSubview(pointView)
            pointViewArray.add(pointView)
            labelArray.add(pswLabel)
            pwdView.addSubview(pswLabel)
            
           
            
        }
        
        let textFiled = UITextField.init(frame: pwdView.frame)
        textFiled.backgroundColor = UIColor.clear
        //设置代理
        textFiled.delegate = self
        //监听编辑状态的变化
        textFiled.addTarget(self, action: #selector(textFiledValueChanged(textFiled:)), for: .editingChanged)
        textFiled.tintColor = UIColor.clear
        textFiled.textColor = UIColor.clear
        textFiled.becomeFirstResponder()
        textFiled.placeholder = "密码为6~10数字"
        textFiled.textAlignment = .center
        textFiled.font = UIFont.systemFont(ofSize: 13)
        //设置键盘类型为数字键盘
        textFiled.keyboardType = .numberPad
        self.textFiled = textFiled
        bgView.addSubview(self.textFiled)
       
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(Info:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(Info:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
     
        //取消按钮
        let cancelButton = UIButton.init(type: .custom)
        cancelButton.frame = CGRect.init(x: 15, y: Int(bgViewH) - buttonH - 15 , width: Int(bgViewW - 60)/2, height: buttonH)
        cancelButton.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        cancelButton.layer.cornerRadius = 22
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(UIColor.black.withAlphaComponent(0.7), for: .normal)
        cancelButton.addTarget(self, action:#selector(cancel(sender:)), for: .touchUpInside)
        bgView.addSubview(cancelButton)
        //确认按钮
        let sureButton = UIButton.init(type: .custom)
        sureButton.frame = CGRect.init(x: Int((bgViewW - 60)/2 + 45) , y: Int(bgViewH) - buttonH - 15, width: Int(bgViewW - 60)/2, height: buttonH)
        sureButton.backgroundColor = buttonColor
        sureButton.layer.cornerRadius = 22
        sureButton.setTitle("确定", for: .normal)
        sureButton.setTitleColor(UIColor.white, for: .normal)
        sureButton.addTarget(self, action:#selector(sure(sender:)), for: .touchUpInside)
        bgView.addSubview(sureButton)
     
        
        self.addSubview(bgView)
    }
    
    @objc func showAndHiddlePwd(sender:UIButton){
    
        sender.isSelected = !sender.isSelected
        
        
        setPwdState()
        
    }
    
    func setPwdState(){
        
        let str = textFiled.text!
        
//        guard str.isEmpty == false else{
//
//            return
//        }
//
        
        if eyeBtn.isSelected {
            
            for pointView  in self.pointViewArray {
                (pointView as! UIView).isHidden = true
            }
            for label in self.labelArray {
                
                (label as! UILabel).text = ""
            }
            
            
            for i in 0..<Int((textFiled.text?.count)!) {
                
                
                let startIndex = str.index(str.startIndex, offsetBy: i)
                let endIndex = str.index(str.startIndex, offsetBy: i + 1)
                
                (self.labelArray.object(at: i) as! UILabel).text = String(str[startIndex ..< endIndex])
            }
            
            
            
        }else {
            
            
            for pointView  in self.pointViewArray {
                (pointView as! UIView).isHidden = true
            }
            
            for i in 0..<Int((textFiled.text?.count)!) {
                (self.pointViewArray.object(at: i) as! UIView).isHidden = false
            }
            
            for label in self.labelArray {
                
                (label as! UILabel).text = ""
            }
            
        }
    }
    
    
   @objc func cancel(sender:UIButton) {
        
        self.removeFromSuperview()
    }
    
   @objc func sure(sender:UIButton) {
        
        print("确定")
     delegate?.passwordCompleteInAlertView(alertView:self, password: self.textFiled.text!)
    }
    
    @objc func textFiledValueChanged(textFiled:UITextField) {
        
       setPwdState()
        
    }
    
    @objc func keyBoardWillShow(Info:NSNotification) {
        
        let userInfos = Info.userInfo![UIKeyboardFrameEndUserInfoKey]
        let heigh = ((userInfos as AnyObject).cgRectValue.size.height)
        self.BGView.center = CGPoint.init(x: self.BGView.center.x , y:self.frame.size.height - heigh - self.BGView.frame.size.height/2 - 10)
    }
    
    @objc func keyBoardWillHide(Info:NSNotification) {
        self.BGView.center = self.center
    }
    
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }
    


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.count == 0 {//判断是是否为删除键
            return true
        }else if (textField.text?.count)! >= pointCount {
            //当输入的密码大于等于n位后就忽略
            return false
        } else {
            return true
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
