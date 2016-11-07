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


