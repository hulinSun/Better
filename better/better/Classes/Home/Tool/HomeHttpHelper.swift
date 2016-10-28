//
//  HomeHttpHelper.swift
//  better
//
//  Created by Hony on 2016/10/26.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON

/// 首页模块的网络请求工具类

class HomeHttpHelper: NSObject {
    
    /// 请求结果的回调
    typealias  resultHandler =  (DataResponse<Any>) -> Void
    
    /// 一些固定的参数

    
    /// 主页 下拉刷新 home接口数据
    class func requestHomeData(back: @escaping (HomePageModel) -> Void){
        
        let realP = NSMutableDictionary.init(dictionary: HttpConst.constParame)
        realP["last_get_time"] = "1476607050"
        realP["page"] = "0"
        realP["pagesize"] = "20"
        let parame =  (realP as NSDictionary) as! [String: String]
        
        /// 方法1 ObjcMapper 处理
        /**
        Alamofire.request("http://open3.bantangapp.com/recommend/index", method: .get, parameters: parame ).responseObject { (response: DataResponse<HomePageModel>) in
            if let homedata = response.result.value{
                back(homedata) // 回调
            }
        }*/
        
        /// 方法2  handyJosn 处理
        Alamofire.request( "http://open3.bantangapp.com/recommend/index", method: .get, parameters: parame).responseString { (rsp) in
            if let model = JSONDeserializer<HomePageModel>.deserializeFrom(json: rsp.result.value){
                back(model)
            }
        }
    }
}
