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


public extension UIColor {
    private class KZ {
        fileprivate var kz_red: CGFloat? = nil
        fileprivate var kz_green: CGFloat? = nil
        fileprivate var kz_blue: CGFloat? = nil
        fileprivate var kz_alpha: CGFloat? = nil
        init(r: CGFloat? = nil, g: CGFloat? = nil,  b: CGFloat? = nil, a: CGFloat? = nil) {
            kz_red = r
            kz_green = g
            kz_blue = b
            kz_alpha = a
        }
    }
    private static var KZKey = "key"
    private var _kz:KZ {
        set {
            objc_setAssociatedObject(self, &UIColor.KZKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, &UIColor.KZKey) as? UIColor.KZ ?? KZ())!
        }
    }
    
    private convenience init(newKz: KZ) {
        let r = (newKz.kz_red ?? 0) / 255.0
        let g = (newKz.kz_green ?? 0) / 255.0
        let b = (newKz.kz_blue ?? 0) / 255.0
        let a = newKz.kz_alpha ?? 1
        if #available(iOS 10, *) {
            self.init(displayP3Red: r, green: g, blue: b, alpha: a)
        } else {
            self.init(red: r, green: g, blue: b, alpha: a)
        }
        self._kz = newKz
    }
    
    public class var kz: UIColor { return UIColor.white }
    
    
    public class func rgb(red: CGFloat, green: CGFloat, blue: CGFloat)-> UIColor{
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1)
    }
    
}
