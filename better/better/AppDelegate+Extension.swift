//
//  a.swift
//  better
//
//  Created by Hony on 2016/10/13.
//  Copyright © 2016年 Hony. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate{
    
    /// 初始化window
    func setupWindow(){
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.backgroundColor = UIColor.white
        
        let tabbar = MainTabbarController()
        tabbar.view.backgroundColor = UIColor.white
        
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
    }
    
}
