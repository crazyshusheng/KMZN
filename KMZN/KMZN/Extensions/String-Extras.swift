//
//  String-Extras.swift
//  Swift Tools
//
//  Created by Fahim Farook on 23/7/14.
//  Copyright (c) 2014 RookSoft Pte. Ltd. All rights reserved.
//

import UIKit



extension String {
    
    
    func sha1() -> String{
        let data = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA1(data, CC_LONG(strLen), result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        //result.deinitialize()
        let shaStr=String(format: hash as String)
        return shaStr
    }
    



    
    
}

