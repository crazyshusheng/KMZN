//
//  DeviceActiveView.swift
//  KMZN
//
//  Created by 陈志超 on 2018/10/18.
//  Copyright © 2018年 czc. All rights reserved.
//

import UIKit

class DeviceActiveView: UIView {

    @IBOutlet weak var activeView: UIView!
    
   
    @IBOutlet weak var gifView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setAnimation()
    }
 
    
    
    func setupUI(){
        
         self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    @IBAction func cancleView(_ sender: Any) {
        
        gifView.stopAnimating()
        self.removeFromSuperview()
    }
    
    
  
    func setAnimation(){
        
        guard let path =  Bundle.main.path(forResource: "device_active.gif", ofType: nil), let data = NSData(contentsOfFile: path),let imageSource = CGImageSourceCreateWithData(data, nil)else {
            return
        }

        var images = [UIImage]()
        var totalDuration : TimeInterval = 0
        
        //从CGImageSource的对象中取得图片张数
        for i in 0 ..<  CGImageSourceGetCount(imageSource){

            //获取CGImageSource中的图片
            let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil)

            let image = UIImage(cgImage: cgImage!)

            images.append(image)


            //CGImageSource中的实体，类型是CFDictionary
            let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) as! NSDictionary
            let gifDict = properties[kCGImagePropertyGIFDictionary] as! NSDictionary
            let frameDuration = gifDict[kCGImagePropertyGIFDelayTime] as! NSNumber
            totalDuration += frameDuration.doubleValue


        }
    
    
      gifView.animationImages = images
      gifView.animationDuration = totalDuration
      gifView.animationRepeatCount = 0
      gifView.startAnimating()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
       
    }
    
}
