//
//  DiscoverSingleController.swift
//  better
//
//  Created by Hony on 2016/11/7.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit


/// 发现页 单品控制器
class DiscoverSingleController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        DiscoverHttpHelper.requestDiscoverSingleCategory { (category) in
        }
        
        DiscoverHttpHelper.requestDiscoverHot { (hot) in
            
        }
    }

    fileprivate func setupUI(){
        view.backgroundColor = UIColor.cyan
    }
}
