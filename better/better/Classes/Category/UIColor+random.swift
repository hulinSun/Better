//
//  UIColor+random.swift
//  better
//
//  Created by Hony on 2016/10/26.
//  Copyright © 2016年 Hony. All rights reserved.
//

import Foundation

extension UIColor{
    /// 随机色
    class func random() -> UIColor {
        return UIColor(red: randomNumber(), green: randomNumber(), blue: randomNumber() , alpha: 1.0)
    }
    
    private class func randomNumber() -> CGFloat {
        // 0 ~ 255
        return CGFloat(arc4random_uniform(256)) / CGFloat(255)
    }
}
