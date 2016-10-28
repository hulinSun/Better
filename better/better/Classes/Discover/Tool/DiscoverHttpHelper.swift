//
//  DiscoverHttpHelper.swift
//  better
//
//  Created by Hony on 2016/10/28.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON

class DiscoverHttpHelper: NSObject {
    
    
    /// 发现页面  文章 下拉刷新 请求借口  (用户原创 最热 ， 最新不处理）GET
    class func requestDiscoverData(back: @escaping (DiscoverTopic) -> Void){
    
        let realP = NSMutableDictionary.init(dictionary: HttpConst.constParame)
        realP["sort_type"] = "1"
        realP["page"] = "0"
        realP["pagesize"] = "20"
        let parame =  (realP as NSDictionary) as! [String: String]
        
        /// 方法2  handyJosn 处理
        Alamofire.request( "http://open3.bantangapp.com/topics/topic/listByUsers", method: .get, parameters: parame).responseString { (rsp) in
            if let model = JSONDeserializer<DiscoverTopic>.deserializeFrom(json: rsp.result.value){
                back(model)
            }
        }
    }
}
