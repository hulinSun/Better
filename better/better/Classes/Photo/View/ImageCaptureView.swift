//
//  ImageCaptureView.swift
//  better
//
//  Created by Hony on 2016/11/25.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class ImageCaptureView: UIView {
    
    fileprivate lazy var scrollView: UIScrollView = {
        let i = UIScrollView()
        return i
    }()
    
    
    fileprivate lazy var redView: UIView = {
        let i = UIView()
        return i
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(redView)
        redView.backgroundColor = UIColor.red
        scrollView.contentSize = CGSize(width: 0, height: 700)
        redView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.size.equalTo(CGSize(width: 200, height: 170))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
