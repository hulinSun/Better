//
//  Theme.swift
//  better
//
//  Created by Hony on 2016/10/28.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit


struct UIConst {
    
    /// 主题色
    static let themeColor = UIColor.init(hexString: "ec5252")
    
    /// 首页pagecontroll 的黄色
    static let yellowPageColor = UIColor.rgb(red: 254, green: 239, blue: 57)
    /// 首页pagecontroll 的灰色
    static let grayPageColor = UIColor.rgb(red: 224, green: 214, blue: 212)
    
    /// 屏幕宽度
    static let screenWidth = UIScreen.main.bounds.width
    /// 屏幕高度
    static let screenHeight = UIScreen.main.bounds.height
    
    /// nav 高度
    static let navHeight = 64.0
}

struct HttpConst {
    
     static let constParame =  [
        "app_id": "com.jzyd.Better",
        "app_installtime": "1476251286",
        "app_versions": "1.5.1",
        "channel_name": "appStore",
        "client_id": "bt_app_ios",
        "client_secret": "9c1e6634ce1c5098e056628cd66a17a5",
        "device_token": "711214f0edd8fe4444aa69d56119e0bbf83bc1675292e4b9e81b0a83a7cdff0a",
        "oauth_token": "1cfdf7dc28066c076c23269874460b58",
        "os_versions": "10.0.2",
        "screensize": "750",
        "track_device_info": "iPhone7%2C2",
        "track_deviceid": "18B31DD0-2B1E-49A9-A78A-763C77FD65BD",
        "track_user_id": "2670024",
        "v": "14"]
    
}
