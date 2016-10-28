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
    
}
