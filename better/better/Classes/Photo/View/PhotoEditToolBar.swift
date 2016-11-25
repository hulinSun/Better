
//
//  PhotoEditToolBar.swift
//  better
//
//  Created by Hony on 2016/11/25.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class PhotoEditToolBar: UIView {
    
    typealias NextClosure = ()-> Void
    typealias CancleClosure = ()-> Void
    typealias RotateClosure = ()-> Void
    var nextClosure: NextClosure?
    var cancleClosure: CancleClosure?
    var rotateClosure: RotateClosure?
    
    @IBAction func retate(_ sender: Any) {
        rotateClosure?()
    }
    /// 下一步
    @IBAction func next(_ sender: Any) {
       nextClosure?()
    }
    
    /// 取消
    @IBAction func cancle(_ sender: Any) {
       cancleClosure?()
    }
}
