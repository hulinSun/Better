//
//  UIView+Extension.swift
//  better
//
//  Created by Hony on 2016/10/26.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit


extension UIView {
    
    var left: CGFloat {
        set {
            var newFrame = frame
            newFrame.origin.x = newValue
            frame = newFrame
        }
        get {
            return frame.origin.x
        }
    }
    
    var top: CGFloat {
        set {
            var newFrame = frame
            newFrame.origin.y = newValue
            frame = newFrame
        }
        get {
            return frame.origin.y
        }
    }
    
    var width: CGFloat {
        set {
            var newFrame = frame
            newFrame.size.width = newValue
            frame = newFrame
        }
        get {
            return frame.size.width
        }
    }
    
    var height: CGFloat {
        set {
            var newFrame = frame
            newFrame.size.height = newValue
            frame = newFrame
        }
        get {
            return frame.size.height
        }
    }
    
    var right: CGFloat {
        set {
            var newFrame = frame
            newFrame.origin.x = newValue - width
            frame = newFrame
        }
        get {
            return left + width
        }
    }
    
    var bottom: CGFloat {
        set {
            var newFrame = frame
            newFrame.origin.y = newValue - height
            frame = newFrame
        }
        get {
            return top + height
        }
    }
}





/**extension UIView {
    
    /// X
    var x:CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    
    /// Y
    var y:CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    
    /// Height
    var height:CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    /// Width
    var width:CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    func removeAllSubViews() {
        subviews.forEach{$0.removeFromSuperview()}
    }
}*/


