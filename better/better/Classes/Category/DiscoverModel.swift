//
//  DiscoverModel.swift
//  better
//
//  Created by Hony on 2016/10/26.
//  Copyright © 2016年 Hony. All rights reserved.
//

import Foundation
import HandyJSON

/// 图片
class Pics: HandyJSON {
    var url: String?
    var tags: String?
    var width: Double = 0
    var height: Double = 0
    
    required init() {} /// 如果定义是struct，连init()函数都不用声明；
}

/// 动态
class Dynamic: HandyJSON {
    
    var comments: String?
    var likes: String?
    var is_collect: Bool = false
    var is_like: Bool = false
    var is_comment: Bool = false
    
    required init() {}
}

/// 评论模型
class Comment:HandyJSON {
    
    var id: String?
    var user_id: String?
    var username: String?
    var nickname: String?
    var avatar: String?
    var conent: String?
    var dateline: String?
    var datestr: String?
    var praise: String?
    var reply: String?
    var is_praise: Bool = false
    var is_hot: Bool = false
    var at_user: User?
    var is_official: Bool = false
    required init() {}
}

class Article: HandyJSON {
    
    var id: String?
    var content: String?
    var author_id: String?
    var type_id: String?
    var post_type: String?
    var relation_id: String?
    var share_url: String?
    var is_recommend: String?
    var create_time: String?
    var publish_time: String?
    var datetime: String?
    var datestr: String?
    var mini_pic_url: String?
    var middle_pic_url: String?
    var author: User?
    var pics: [Pics]?
    var dynamic: [Dynamic]?
    var comments: [Comment]?
    var trace_id: String?
    var brand_product: String?
    var tags: [[String : AnyObject]]?
    
    required init() {}
    
}





