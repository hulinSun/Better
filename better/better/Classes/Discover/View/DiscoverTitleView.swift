//
//  DiscoverTitleView.swift
//  better
//
//  Created by Hony on 2016/10/28.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class DiscoverTitleView: UIView {
    
   class func discoverTitleView() -> DiscoverTitleView {
    return Bundle.main.loadNibNamed("DiscoverTitleView", owner: nil, options: nil)?.last as! DiscoverTitleView
    }
    
    enum ItemSelected {
        case left, right
    }
    
    typealias clickItemClosure = (_ itemSel: ItemSelected) ->Void
    
    
    var clickItemback: clickItemClosure?
    
    @IBOutlet weak var botLine: UIView!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        leftBtn.isSelected = true
    }
    
    
    /// 点击左边按钮
    @IBAction func leftClick(_ sender: AnyObject) {
        leftBtn.isSelected = true
        rightBtn.isSelected = false
        clickItemback?(ItemSelected.left)

//        UIView.animate(withDuration: 0.25) {
//            self.botLine.snp.remakeConstraints({ (make) in
//                make.centerX.equalTo(self.leftBtn.snp.centerX)
//            })
//            self.layoutIfNeeded()
//        }
        
        UIView.animate(withDuration: 0.3) {
            self.botLine.left -= 50
        }
    }
    
    /// 点击右边按钮
    @IBAction func rightClick(_ sender: AnyObject) {
        leftBtn.isSelected = false
        rightBtn.isSelected = true
        clickItemback?(ItemSelected.right)
        
        UIView.animate(withDuration: 0.3) {
            self.botLine.left += 50
        }
        
//        UIView.animate(withDuration: 0.25) {
//            self.botLine.snp.remakeConstraints({ (make) in
//                make.centerX.equalTo(self.rightBtn.snp.centerX)
//            })
//            self.layoutIfNeeded()
//        }
        
    }
    
}
