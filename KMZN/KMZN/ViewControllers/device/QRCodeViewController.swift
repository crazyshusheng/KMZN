//
//  QRCodeViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/27.
//  Copyright © 2018年 czc. All rights reserved.
//
import UIKit

import AVFoundation


protocol QRCodeViewControllerDelegate:NSObjectProtocol{
    
    func scanInfo(codeInfo:String,type:Int)
}

class QRCodeViewController: ThemeViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    
    var codeType = 0
    
    var session:AVCaptureSession!
    
    var screenWidth : CGFloat!
    
    var screenHeight:CGFloat!
    
    var halfWidth:CGFloat = 130
    
    weak var delegate:QRCodeViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        screenWidth = self.view.bounds.width
        
        screenHeight = self.view.bounds.height
        
        
        
        setView()
        
        setCamera()
        
    }
    
    

    //设置除了扫描区以外的视图
    
    func setView(){
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth/2 - halfWidth, height: screenHeight))
        
        leftView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        self.view.addSubview(leftView)
        
        
        
        let rightView = UIView(frame: CGRect(x: screenWidth/2 + halfWidth, y: 0, width: screenWidth/2 - halfWidth, height: screenHeight))
        
        rightView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        self.view.addSubview(rightView)
        
        
        
        let topView = UIView(frame: CGRect(x: screenWidth/2 - halfWidth, y: 0, width: halfWidth * 2, height: halfWidth))
        
        topView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        self.view.addSubview(topView)
        
    
        let bottomView = UIView(frame: CGRect(x: screenWidth/2 - halfWidth, y: halfWidth * 3, width: halfWidth * 2, height: screenHeight - halfWidth * 3))
        
        bottomView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        self.view.addSubview(bottomView)
        
        
        
        let tipLabel = UILabel.init(frame: CGRect.init(x:  screenWidth/2 - halfWidth, y: halfWidth * 3 + 20, width: halfWidth * 2, height: 20))
        tipLabel.tag = 10
        tipLabel.text = "放入框内，自动扫描"
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.textColor = UIColor.white
        tipLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(tipLabel)
        
        
        
    }
    
    
    
    //设置相机
    
    func setCamera(){
        
        //获取摄像设备
        
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else {
            
            return
            
        }
        
        do {
            
            //创建输入流
            
            let input =  try AVCaptureDeviceInput(device: device)
            
            //创建输出流
            
            let output = AVCaptureMetadataOutput()
            

            //设置会话
            
            session = AVCaptureSession()
            
            //连接输入输出
            
            if session.canAddInput(input){
                
                session.addInput(input)
                
            }
            
            if session.canAddOutput(output){
                
                
                session.addOutput(output)
                
                //设置输出流代理，从接收端收到的所有元数据都会被传送到delegate方法，所有delegate方法均在queue中执行
                
                output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                
                //设置扫描二维码类型
                
                output.metadataObjectTypes = [ AVMetadataObject.ObjectType.qr]
                
                //扫描区域
                
                //rectOfInterest 属性中x和y互换，width和height互换。
                
                output.rectOfInterest = CGRect(x: 100/screenHeight, y: (screenWidth/2-100)/screenWidth, width: 200/screenHeight, height: 200/screenWidth)
                
            }
            
    
            //捕捉图层
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: session)
            
            previewLayer.videoGravity = .resizeAspectFill
            
            previewLayer.frame = self.view.layer.bounds
            
            self.view.layer.insertSublayer(previewLayer, at: 0)
            
            
            
            //持续对焦
            
            if device.isFocusModeSupported(.continuousAutoFocus){
                
                try  input.device.lockForConfiguration()
                
                input.device.focusMode = .continuousAutoFocus
                
                input.device.unlockForConfiguration()
                
            }
            
            session.startRunning()
            
            
            
        } catch  {
            
            
            
        }
        
        
        
    }
    
    
    
    
    
    //扫描完成的代理
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        
        
        session?.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject
            
            
            
            let str = readableObject.stringValue!
            
            print(str)
            
            self.delegate?.scanInfo(codeInfo: str, type: codeType)
            
            Utils.showHUD(info: "扫描成功")
            
            self.navigationController?.popViewController(animated: true)
            
            
        }

    }
    
}
