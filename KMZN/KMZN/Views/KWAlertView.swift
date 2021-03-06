//
//  KWAlertView.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/23.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

protocol KWAlertViewDelegate:NSObjectProtocol{
    func passwordCompleteInAlertView(alertView:KWAlertView, name:String)
}

class KWAlertView: UIView,UITextFieldDelegate {
    
    let ScreenH = UIScreen.main.bounds.size.height
    let ScreenW = UIScreen.main.bounds.size.width
    let buttonH = 44
    let borderH = 40
    let borderW = 15
    let pointSize = CGSize.init(width: 12, height: 12)
    let pointCount = 6
    var pointViewArray = NSMutableArray.init()
    var BGView = UIView.init()
    var textFiled = UITextField()
    
    
    let buttonColor = UIColor(red:0.19, green:0.67, blue:0.91, alpha:1.00)
    
    
    weak var delegate:KWAlertViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    func setupUI() {
        //背景颜色
        self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        //弹框背景
        let bgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW - 60, height: 180))
        bgView.center = self.center
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 5
        bgView.layer.masksToBounds = true
        BGView = bgView
        let bgViewW = bgView.frame.size.width
        let bgViewH = bgView.frame.size.height
        
        //tipsLabel
        let tipLabel = UILabel.init(frame: CGRect.init(x: 0, y: 20, width: bgViewW, height: 20))
        tipLabel.tag = 10
        tipLabel.text = "请输入管理员密码"
        tipLabel.font = UIFont.systemFont(ofSize: 15)
        tipLabel.textAlignment = NSTextAlignment.center
        bgView.addSubview(tipLabel)

        
        let pwdView = UIView.init(frame: CGRect.init(x:15 , y: Int(tipLabel.frame.origin.y + 45), width: Int(bgView.frame.size.width) - borderW * 2, height: borderH))
        pwdView.layer.cornerRadius = 12
        pwdView.layer.borderWidth = 0.6
        pwdView.layer.borderColor = UIColor.gray.cgColor
        bgView.addSubview(pwdView)
        
        
        
        let textFiled = UITextField.init(frame: pwdView.frame)
      
        textFiled.textAlignment = .center
        //设置代理
        textFiled.delegate = self
      
        textFiled.becomeFirstResponder()
        self.textFiled = textFiled
        bgView.addSubview(self.textFiled)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(Info:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(Info:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        
        //line
        let line = UIImageView.init(frame: CGRect.init(x: 3, y: Int(bgViewH) - buttonH, width: Int(bgViewW) - 6, height: 1))
        line.image = UIImage.init(named: "分隔线1")
        line.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        bgView.addSubview(line)
        
        
        //line
        let line2 = UIImageView.init(frame: CGRect.init(x: Int((bgViewW )/2) , y: Int(bgViewH) - buttonH, width: 1, height: buttonH))
        line2.image = UIImage.init(named: "分隔线2")
        line2.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        bgView.addSubview(line2)
        
        
        
        //取消按钮
        let cancelButton = UIButton.init(type: .custom)
        cancelButton.frame = CGRect.init(x: 0, y: Int(bgViewH) - buttonH , width: Int(bgViewW / 2), height: buttonH)
        //        cancelButton.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        //        cancelButton.layer.cornerRadius = 5
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(UIColor.black.withAlphaComponent(0.8), for: .normal)
        cancelButton.addTarget(self, action:#selector(cancel(sender:)), for: .touchUpInside)
        bgView.addSubview(cancelButton)
        
        
        //确认按钮
        let sureButton = UIButton.init(type: .custom)
        sureButton.frame = CGRect.init(x: Int((bgViewW )/2 ) , y: Int(bgViewH) - buttonH, width: Int(bgViewW )/2, height: buttonH)
        //        sureButton.backgroundColor = THEME_COLOR
        //        sureButton.layer.cornerRadius = 5
        sureButton.setTitle("确定", for: .normal)
        sureButton.setTitleColor(THEME_COLOR, for: .normal)
        sureButton.addTarget(self, action:#selector(sure(sender:)), for: .touchUpInside)
        bgView.addSubview(sureButton)
        
        
        self.addSubview(bgView)
    }
    
    @objc func cancel(sender:UIButton) {
        
        self.removeFromSuperview()
    }
    
    @objc func sure(sender:UIButton) {
        
        print("确定")
        delegate?.passwordCompleteInAlertView(alertView:self, name: self.textFiled.text!)
    }
    

    @objc func keyBoardWillShow(Info:NSNotification) {
        
        let userInfos = Info.userInfo![UIKeyboardFrameEndUserInfoKey]
        let heigh = ((userInfos as AnyObject).cgRectValue.size.height)
        self.BGView.center = CGPoint.init(x: self.BGView.center.x , y:ScreenH - heigh - self.BGView.frame.size.height/2 - 60)
    }
    
    @objc func keyBoardWillHide(Info:NSNotification) {
        self.BGView.center = self.center
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

