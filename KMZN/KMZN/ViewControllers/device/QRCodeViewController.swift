//
//  QRCodeViewController.swift
//  KMZN
//
//  Created by 陈志超 on 2018/8/27.
//  Copyright © 2018年 czc. All rights reserved.


let kMargin = 50
let kBorderW = 150
let scanViewW = UIScreen.main.bounds.width - CGFloat(kMargin * 2)
let scanViewH = UIScreen.main.bounds.width - CGFloat(kMargin * 2)

import UIKit
import AVFoundation


protocol QRCodeViewControllerDelegate:NSObjectProtocol{
    
    func scanInfo(codeInfo:String,type:Int)
}

class QRCodeViewController: ThemeViewController {
    
    
    var scanView: UIView? = nil
    var scanImageView: UIImageView? = nil
    var session = AVCaptureSession()
    var codeType = 0
    var delegate:QRCodeViewControllerDelegate?
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        resetAnimatinon()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        setupMaskView()
        setupScanView()
        scaning()
        NotificationCenter.default.addObserver(self, selector: #selector(resetAnimatinon), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// 整体遮罩设置
    fileprivate func setupMaskView() {
        
        let maskView = UIView(frame: CGRect(x: (-(view.bounds.height - view.bounds.width) / 2), y: -44, width: view.bounds.height, height: view.bounds.height))
        maskView.layer.borderWidth = (view.bounds.height - scanViewW) / 2
        
        maskView.layer.borderColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        
        view.addSubview(maskView)
        
        
        
    }
    
    /// 扫描区域设置
    fileprivate func setupScanView() {
        
        scanView = UIView(frame: CGRect(x: CGFloat(kMargin), y: CGFloat((view.bounds.height - scanViewW) / 2) - 44, width: scanViewW, height: scanViewH))
        scanView?.backgroundColor = UIColor.clear
        scanView?.clipsToBounds = true
        view.addSubview(scanView!)
        
        //添加动画后 点击会报错 
        scanView?.isUserInteractionEnabled = false
        
        let label = UILabel.init(frame: CGRect.init(x:  CGFloat(kMargin), y: (scanView?.frame.origin.y)! + scanViewH + 20, width: scanViewW, height: 20))
        label.text = "放入框内，自动扫描"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = UIColor.white
        view.addSubview(label)
        
        
        scanImageView = UIImageView(image: UIImage.init(named: "sweep_bg_line.png"))
        let widthOrHeight: CGFloat = 18
        
        let topLeft = UIButton(frame: CGRect(x: 0, y: 0, width: widthOrHeight, height: widthOrHeight))
        topLeft.setImage(UIImage.init(named: "sweep_kuangupperleft.png"), for: .normal)
        scanView?.addSubview(topLeft)
        
        let topRight = UIButton(frame: CGRect(x: scanViewW - widthOrHeight, y: 0, width: widthOrHeight, height: widthOrHeight))
        topRight.setImage(UIImage.init(named: "sweep_kuangupperright.png"), for: .normal)
        scanView?.addSubview(topRight)
        
        let bottomLeft = UIButton(frame: CGRect(x: 0, y: scanViewH - widthOrHeight, width: widthOrHeight, height: widthOrHeight))
        bottomLeft.setImage(UIImage.init(named: "sweep_kuangdownleft.png"), for: .normal)
        scanView?.addSubview(bottomLeft)
        
        let bottomRight = UIButton(frame: CGRect(x: scanViewH - widthOrHeight, y: scanViewH - widthOrHeight, width: widthOrHeight, height: widthOrHeight))
        bottomRight.setImage(UIImage.init(named: "sweep_kuangdownright.png"), for: .normal)
        scanView?.addSubview(bottomRight)
    }
    
    
    /// 开始扫描
    fileprivate func scaning() {
        
        //获取摄像设备
        
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else {
            
            return
            
        }
        
        do {
            //创建输入流
            let input = try AVCaptureDeviceInput.init(device: device)
            //创建输出流
            let output = AVCaptureMetadataOutput()
           
            
            session.canSetSessionPreset(.high)
            
             //连接输入输出
            if session.canAddInput(input){
                
                session.addInput(input)
                
            }
            
            if session.canAddOutput(output){
                
                
                session.addOutput(output)
                
               
                
                //设置扫描二维码类型
                
                output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr,
                                              AVMetadataObject.ObjectType.ean8,
                                              AVMetadataObject.ObjectType.ean13,
                                              AVMetadataObject.ObjectType.code128]
                
               
                //设置输出流代理，从接收端收到的所有元数据都会被传送到delegate方法，所有delegate方法均在queue中执行
                
                output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                
                
                //rectOfInterest 属性中x和y互换，width和height互换。
                
                output.rectOfInterest = CGRect(x: 100/SCREEN_HEIGHT, y: (SCREEN_WIDTH/2-100)/SCREEN_WIDTH, width: scanViewW/SCREEN_HEIGHT, height: scanViewW/SCREEN_WIDTH)
                
                
            }
        
        
             //捕捉图层
            let layer = AVCaptureVideoPreviewLayer(session: session)
            layer.videoGravity = .resizeAspectFill
            layer.frame = view.layer.bounds
            view.layer.insertSublayer(layer, at: 0)
            
            
            //持续对焦
            
            if (device.isFocusModeSupported(.continuousAutoFocus)){
                
                try  input.device.lockForConfiguration()
                
                input.device.focusMode = .continuousAutoFocus
                
                input.device.unlockForConfiguration()
                
            }
            
            
            //开始捕捉
            session.startRunning()
            
        } catch let error as NSError  {
            print("errorInfo\(error.domain)")
        }
    }
    
    ///重置动画
    @objc fileprivate func resetAnimatinon() {
        
        let anim = scanImageView?.layer.animation(forKey: "translationAnimation")
        if (anim != nil) {
            //将动画的时间偏移量作为暂停时的时间点
            let pauseTime = scanImageView?.layer.timeOffset
            //根据媒体时间计算出准确的启动时间,对之前暂停动画的时间进行修正
            let beginTime = CACurrentMediaTime() - pauseTime!
            ///偏移时间清零
            scanImageView?.layer.timeOffset = 0.0
            //设置动画开始时间
            scanImageView?.layer.beginTime = beginTime
            scanImageView?.layer.speed = 1.1
        } else {
            
            let scanImageViewH = 241
            let scanViewH = view.bounds.width - CGFloat(kMargin) * 2
            let scanImageViewW = scanView?.bounds.width
            
            scanImageView?.frame = CGRect(x: 0, y: -scanImageViewH, width: Int(scanImageViewW!), height: scanImageViewH)
            let scanAnim = CABasicAnimation()
            scanAnim.keyPath = "transform.translation.y"
            scanAnim.byValue = [scanViewH]
            scanAnim.duration = 1.8
            scanAnim.repeatCount = MAXFLOAT
            scanImageView?.layer.add(scanAnim, forKey: "translationAnimation")
            scanView?.addSubview(scanImageView!)
        }
    }
    
    
    
}
    

extension QRCodeViewController:AVCaptureMetadataOutputObjectsDelegate{
    
    
    //扫描完成的代理
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        
        
        session.stopRunning()
        
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
