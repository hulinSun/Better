//
//  PhotoFilterController.swift
//  better
//
//  Created by Hony on 2016/11/30.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import GPUImage

class PhotoFilterController: UIViewController {

    
    fileprivate lazy var filterBar: PhotoFilterBar = {
        let i = PhotoFilterBar.loadFromNib()
        return i
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    private func setupUI(){
        view.backgroundColor = .white
        view.addSubview(filterBar)
        filterBar.snp.makeConstraints { (make) in
            make.right.left.bottom.equalToSuperview()
            make.height.equalTo(290)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
