//
//  HttpTool.swift
//  better
//
//  Created by Hony on 2016/10/26.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

import Alamofire


class HttpTool: NSObject {
    
    /// GET 请求
    ///
    /// - parameter url:        url
    /// - parameter parameters: 参数
    /// - parameter respone:    返回结果
    class func GET(url: String, parameters:[String: AnyObject], respone: @escaping(DataResponse<Any>) -> Void){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (rsp) in
            respone(rsp)
        }
    }
    
    
    
    /// POST 请求
    ///
    /// - parameter url:        url
    /// - parameter parameters: 参数
    /// - parameter respone:    返回结果
    class func POST(url:String , parameters:[String : AnyObject] , respone: @escaping(DataResponse<Any>) -> Void){
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { (rsp) in
            respone(rsp)
        }
    }
    
}
