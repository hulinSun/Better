//
//  Topic.swift
//  better
//
//  Created by Hony on 2016/10/26.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

import HandyJSON
import ObjectMapper

/// 话题的 账号模型
class User: Mappable , HandyJSON {
    
    var user_id: String?  /// 用户id
    var nickname: String? /// 用户昵称
    var avatar: String?  /// 用户头像
    var is_official: Bool  =  false /// 是否签约？
    var article_topic_count: String? /// 话题个数
    var post_count: String?/// 转发数
    
    required init?(map: Map){}
    func mapping(map: Map) {
        user_id <- map["user_id"]
        nickname <- map["nickname"]
        avatar <- map["avatar"]
        is_official <- map["is_official"]
        article_topic_count <- map["article_topic_count"]
        post_count <- map["post_count"]
    }
    
    
    required init() {} /// 如果是结构体，这个都可以不写
}


/// 话题模型
class Topic: Mappable  , HandyJSON {
    
    var id: String?
    var type: String?
    var type_id: String?
    var title: String?
    var subtitle: String?
    var pic: String?
    var desc: String?
    var is_show_like: Bool = false
    var is_recommend: Bool = false
    var create_time_str: String?
    var islike: Bool = false
    var likes: String?
    var views: String?
    var comments: String?
    var update_time: String?
    var user: User?
    var pics: [Pics] = [Pics]()
    var channel: [String: AnyObject]?
    var video: [String: AnyObject]?
    
    required init?(map: Map){}
    func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        type_id <- map["type_id"]
        title <- map["title"]
        subtitle <- map["subtitle"]
        pic <- map["pic"]
        is_show_like <- map["is_show_like"]
        is_recommend <- map["is_recommend"]
        create_time_str <- map["create_time_str"]
        islike <- map["islike"]
        likes <- map["likes"]
        views <- map["views"]
        comments <- map["comments"]
        update_time <- map["update_time"]
        user <- map["user"]
        pics <- map["pics"]
        channel <- map["channel"]
        video <- map["video"]
    }
    
    required init() {}
}



/// 首页轮播图对应的模型
class Banner: Mappable , HandyJSON  {
    
    var id: String?
    var title: String?
    var sub_title: String?
    var type: String?
    var topic_type: String?
    var photo: String?
    var extend: String?
    var browser_url: String?
    var index: String?
    var parent_id: String?
    var photo_width: String?
    var photo_height: String?
    var is_show_icon: Bool = false
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        sub_title <- map["sub_title"]
        type <- map["type"]
        topic_type <- map["topic_type"]
        photo <- map["photo"]
        extend <- map["extend"]
        browser_url <- map["browser_url"]
        index <- map["index"]
        parent_id <- map["parent_id"]
        photo_width <- map["photo_width"]
        photo_height <- map["photo_height"]
        is_show_icon <- map["is_show_icon"]
    }
    
    required init() {}
}


class HomeData: Mappable , HandyJSON {
    
    class InsertElement: Mappable , HandyJSON{
        
        var  index: Double = 0
        var element_list: [Banner]?
        
        required init?(map: Map){}
        func mapping(map: Map) {
            index <- map["index"]
            element_list <- map["element_list"]
        }
        required init() {}
    }
    
    var topic: [Topic]?
    var append_extend: [String: AnyObject]?
    var banner : [Banner]?
    var category_element: [Banner]?
    var insert_element: [InsertElement]?
    
    required init?(map: Map){}
    func mapping(map: Map) {
        topic <- map["topic"]
        append_extend <- map["append_extend"]
        banner <- map["banner"]
        category_element <- map["category_element"]
        insert_element <- map["insert_element"]
    }
    
    required init() {}
}




/// 最终的大模型
class HomePageModel: Mappable , HandyJSON {
    
    var status: String?
    var msg: String?
    var ts: Double = 0
    var data :HomeData?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        status <- map["status"]
        msg <- map["msg"]
        ts <- map["ts"]
        data <- map["data"]
    }
    
    required init() {}
}










