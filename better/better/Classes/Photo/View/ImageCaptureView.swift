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
        scrollView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(redView)
        redView.backgroundColor = UIColor.red
        scrollView.contentSize = CGSize(width: 0, height: 700)
        redView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
            make.top.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 60))
        }
        // 画图层
        let topLayer = CALayer()
        topLayer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
        topLayer.bounds = CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: 30)
        topLayer.position = CGPoint(x: 0, y: 0)
        topLayer.anchorPoint = CGPoint(x: 0, y: 0)
        
        let bottomLay = CALayer()
        bottomLay.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
        bottomLay.bounds = CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: 30)
        bottomLay.position = CGPoint(x: 0, y: frame.size.height - 30)
        bottomLay.anchorPoint = CGPoint(x: 0, y: 0)
        layer.addSublayer(topLayer)
        layer.addSublayer(bottomLay)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
