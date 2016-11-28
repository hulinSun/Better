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
        i.addSubview(self.imgView)
        return i
    }()
    
    fileprivate lazy var imgView: UIImageView = {
        let i = UIImageView()
        return i
    }()
    
    var img: UIImage!{
        didSet{
           imgView.image = img
        }
    }
    
    var contSize: CGSize!{
        didSet{
           scrollView.contentSize = contSize
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        imgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
