//
//  ButtonWithUpImage.swift
//  COHTB
//
//  Created by tongdow on 16/6/6.
//  Copyright © 2016年 Tongdow. All rights reserved.
//

import UIKit

class ButtonWithUpImage: UIButton {
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let height=self.frame.size.height
        let width=self.frame.size.width
        
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRect.init(x: 0, y: height-20, width: width, height: (titleLabel?.frame.size.height)!)
        titleLabel?.textAlignment = .center
        
        imageView?.frame = CGRect.init(x: 0, y: 0, width: width, height: height-20)
        imageView?.contentMode = UIViewContentMode.center

        
       
    }
}

