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
    }
    
    /// 点击右边按钮
    @IBAction func rightClick(_ sender: AnyObject) {
        leftBtn.isSelected = false
        rightBtn.isSelected = true
        clickItemback?(ItemSelected.right)
    }
    
    
    
}
