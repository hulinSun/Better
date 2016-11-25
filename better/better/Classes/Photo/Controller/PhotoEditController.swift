//
//  PhotoEditController.swift
//  better
//
//  Created by Hony on 2016/11/25.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

/// 图片编辑控制器
class PhotoEditController: UIViewController {

    
    fileprivate lazy var editBar: PhotoEditToolBar = {
        let i = PhotoEditToolBar.loadFromNib()
        return i
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(editBar)
        editBar.backgroundColor = UIColor.random()
        editBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
}
