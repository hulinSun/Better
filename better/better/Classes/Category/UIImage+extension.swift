//
//  UIImage+extension.swift
//  better
//
//  Created by Hony on 2016/11/28.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resizeTo(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let i = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return i ?? self
    }
    
    func cropImage(withSize: CGSize) -> UIImage {
        return self
    }
    
}
