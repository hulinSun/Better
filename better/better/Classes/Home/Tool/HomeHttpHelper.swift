//
//  HomeHttpHelper.swift
//  better
//
//  Created by Hony on 2016/10/26.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import Alamofire

/// 首页模块的网络请求工具类

class HomeHttpHelper: NSObject {
    
    /// 请求结果的回调
    typealias  resultHandler =  (DataResponse<Any>) -> Void
    
    /// 一些固定的参数
    private static let constParame =  [
        "app_id": "com.jzyd.Better",
        "app_installtime": "1476251286",
        "app_versions": "1.5.1",
        "channel_name": "appStore",
        "client_id": "bt_app_ios",
        "client_secret": "9c1e6634ce1c5098e056628cd66a17a5",
        "device_token": "711214f0edd8fe4444aa69d56119e0bbf83bc1675292e4b9e81b0a83a7cdff0a",
        "last_get_time": "1476607050",
        "oauth_token": "1cfdf7dc28066c076c23269874460b58",
        "os_versions": "10.0.2",
        "page": "0",
        "pagesize" : "20",
        "screensize": "750",
        "track_device_info": "iPhone7%2C2",
        "track_deviceid": "18B31DD0-2B1E-49A9-A78A-763C77FD65BD",
        "track_user_id": "2670024",
        "v": "14"]

    
    /// 主页 下拉刷新 home接口数据
    class func requestHomeData(back: @escaping (HomePageModel) -> Void){
        
        let parame = [
            "app_id": "com.jzyd.Better",
            "app_installtime": "1476251286",
            "app_versions": "1.5.1",
            "channel_name": "appStore",
            "client_id": "bt_app_ios",
            "client_secret": "9c1e6634ce1c5098e056628cd66a17a5",
            "device_token": "711214f0edd8fe4444aa69d56119e0bbf83bc1675292e4b9e81b0a83a7cdff0a",
            "last_get_time": "1476607050",
            "oauth_token": "1cfdf7dc28066c076c23269874460b58",
            "os_versions": "10.0.2",
            "page": "0",
            "pagesize" : "20",
            "screensize": "750",
            "track_device_info": "iPhone7%2C2",
            "track_deviceid": "18B31DD0-2B1E-49A9-A78A-763C77FD65BD",
            "track_user_id": "2670024",
            "v": "14"]
        
        Alamofire.request("http://open3.bantangapp.com/recommend/index", method: .get, parameters: parame).responseObject { (response: DataResponse<HomePageModel>) in
            if let homedata = response.result.value{
                back(homedata) // 回调
            }
        }
    }
}
