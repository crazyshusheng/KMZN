//
//  UIColor+extension.swift
//  HopeTools
//
//  Created by tongdow on 16/7/30.
//  Copyright © 2016年 hopewind. All rights reserved.
//
import UIKit

extension UIColor {
    
    class func colorWithCustom(r: CGFloat, g:CGFloat, b:CGFloat,alpha:Double = 1) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: CGFloat(alpha))
    }
    
    class func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return UIColor.colorWithCustom(r: r, g: g, b: b)
    }
    
}
