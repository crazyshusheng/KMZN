//
//  ButtonWithRightImage.swift
//  TongdowTools
//
//  Created by tongdow on 2016/11/7.
//  Copyright © 2016年 tongdow. All rights reserved.
//

import UIKit

class ButtonWithRightImage: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        let height=self.frame.size.height
        let width=self.frame.size.width
        
        let conentWidth=(titleLabel?.frame.size.width)!+(imageView?.frame.size.width)!+5
        let left=(width-conentWidth)/2
        titleLabel?.frame =  CGRect.init(x:left,y: 0, width: (titleLabel?.frame.size.width)!, height:height)
        titleLabel?.textAlignment = .center
        imageView?.frame=CGRect.init(x:left+(titleLabel?.frame.size.width)!+5,y: 0,width: (imageView?.frame.size.width)!,height:height)
        imageView?.contentMode=UIViewContentMode.center
        
    }

}
