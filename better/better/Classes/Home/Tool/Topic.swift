//
//  Topic.swift
//  better
//
//  Created by Hony on 2016/10/26.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit


/// 账号模型
class User: NSObject {
    
    var user_id: String?  /// 用户id
    var nickname: String? /// 用户昵称
    var avatar: String?  /// 用户头像
    var is_official: Bool  =  false /// 是否签约？
    var article_topic_count: String? /// 话题个数
    var post_count: String?/// 转发数
    
}


/// 话题模型
class Topic: NSObject {
    
    var id: String?
    var type: String?
    var type_id: String?
    var title: String?
    var subtitle: String?
    var pic: String?
    var is_show_like: Bool = false
    var is_recommend: Bool = false
    var create_time_str: String?
    var islike: Bool = false
    var likes: String?
    var views: String?
    var comments: String?
    var update_time: String?
    var user: User?
    var pics: [[String: AnyObject]]?
    var channel: [String: AnyObject]?
    var video: [String: AnyObject]?
}



/// 首页轮播图对应的模型
class Banner: NSObject {
    
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
    
}
