//
//  UIScrollView+Refresh.swift
//  BetterRefresh
//
//  Created by Hony on 2016/10/20.
//  Copyright © 2016年 Hony. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

private var betterHeaderRefreshViewHeightKey: UInt8 = 0
private var betterHeaderRefreshViewKey: UInt8 = 0

 extension UIScrollView {
    
    /// 下拉滑动距离的高度
     var betterHeaderRefreshViewHeight: NSNumber? {
        get {
            return objc_getAssociatedObject(self, &betterHeaderRefreshViewHeightKey) as? NSNumber
        }
        set {
            objc_setAssociatedObject(self, &betterHeaderRefreshViewHeightKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    /// 头部下拉刷新控件
    var betterHeader : BetterRefreshHeader? {
        get {
            return objc_getAssociatedObject(self, &betterHeaderRefreshViewKey) as? BetterRefreshHeader
        }
        set {
            objc_setAssociatedObject(self, &betterHeaderRefreshViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 头部 下拉刷新 方法
    func addBetterRefreshHeader(handel: @escaping ()->()) {

        if self.betterHeaderRefreshViewHeight == nil {
            self.betterHeaderRefreshViewHeight = NSNumber.init(value: 60)
        }
        self.betterHeader = BetterRefreshHeader(scrollView: self, refreshHeight: CGFloat(self.betterHeaderRefreshViewHeight!.floatValue), refreshBlock: handel)
        self.insertSubview(self.betterHeader!, at: 0)
    }
    
}
