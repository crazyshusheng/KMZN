//
//  TimeSelectView.swift
//  KMZN
//
//  Created by 陈志超 on 2018/10/9.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

import UIKit

protocol TimeSelectViewDelegate:NSObjectProtocol{
    func timeSelectCompleteInAlertView(alertView:TimeSelectView, time:String)
}

class  TimeSelectView: UIView {
    
    let ScreenH = UIScreen.main.bounds.size.height
    let ScreenW = UIScreen.main.bounds.size.width
    let buttonH = 44
    let borderH = 44
    let borderW = 15
    let pointSize = CGSize.init(width: 12, height: 12)
    let pointCount = 6
    var pointViewArray = NSMutableArray.init()
    var BGView = UIView.init()
    var datepicker = UIDatePicker()
    
    
    let buttonColor = UIColor(red:0.19, green:0.67, blue:0.91, alpha:1.00)
    
    
    weak var delegate:TimeSelectViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    func setupUI() {
        //背景颜色
        self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        //弹框背景
        let bgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW - 30, height: 250))
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
        tipLabel.text = "选择时间"
        tipLabel.font = UIFont.systemFont(ofSize: 15)
        tipLabel.textAlignment = NSTextAlignment.center
        bgView.addSubview(tipLabel)
        //line
        let line = UIView.init(frame: CGRect.init(x: 0, y: tipLabel.frame.size.height + 1, width: bgViewW, height: 1))
        line.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        line.isHidden = true
        bgView.addSubview(line)
        
      
        datepicker.frame = CGRect.init(x: 0, y: 40, width:ScreenW - 30 , height: 150)
      
        datepicker.datePickerMode = .time
        
        
        bgView.addSubview(datepicker)
        
     
        
        
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
    
    @objc func cancel(sender:UIButton) {
        
        self.removeFromSuperview()
    }
    
    @objc func sure(sender:UIButton) {
        
        print("确定")
        let timeStr = Utils.getDateStrFromTime(time: Int(datepicker.date.timeIntervalSince1970), formatStr: "HH:mm")
        delegate?.timeSelectCompleteInAlertView(alertView: self, time: timeStr)
    }
    
    
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
     
        super.touchesBegan(touches, with: event)
        self.removeFromSuperview()
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
