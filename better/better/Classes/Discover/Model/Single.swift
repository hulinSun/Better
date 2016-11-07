//
//  Single.swift
//  better
//
//  Created by Hony on 2016/11/7.
//  Copyright © 2016年 Hony. All rights reserved.
//

import Foundation

import HandyJSON

class SingleProCategoryItem: HandyJSON {
    var id: String?
    var name: String?
    var en_name: String?
    var pic: String?
    required init() {}
}

class SingleProCategory: HandyJSON {
    
    var status: Double?
    var msg: String?
    var ts: Double?
    var data: SingleProCategoryData?
    required init() {}
    
    class SingleProCategoryData: HandyJSON {
        var category_list: [SingleProCategoryItem]?
        var banner: [AnyObject]?
        required init() {}
    }
}


class SingleProDynamic: HandyJSON {
    
    var comments: String?
    var likes: String?
    var is_collect: Bool = false
    var is_like: Bool = false
    var is_comment: Bool = false
    required init() {}
}

/// 评论模型
class SingleProComment: HandyJSON {
    var id: String?
    var user_id: String?
    var username: String?
    var nickname: String?
    var avatar: String?
    var conent: String?
    var dateline: Double?
    var datestr: String?
    var praise: Double?
    var reply: Double?
    var is_praise: Double?
    var is_hot: Double?
    var at_user: User?
    var product: AnyObject?
    var is_official:  Double?
    required init() {}
}


class SinglePrdHotRecommond: HandyJSON {
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
    var tags: [AnyObject]?
    var author: User?
    var pics: [Pics]?
    var dynamic: SingleProDynamic?
    var product: [AnyObject]?
    var comments: [SingleProComment]?
    var trace_id: String?
    var brand_product: [AnyObject]?
    
    required init() {}
}


class SingleProdHot: HandyJSON {
    var status: Double?
    var msg: String?
    var ts: Double?
    var data: [SinglePrdHotRecommond]?
    
    required init() {}
}



