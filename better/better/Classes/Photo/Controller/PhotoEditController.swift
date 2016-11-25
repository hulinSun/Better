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
    
    fileprivate lazy var captureView: ImageCaptureView = {
        let i = ImageCaptureView(frame:
            CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: UIConst.screenHeight - 200.0))
        return i
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        response()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(editBar)
        editBar.backgroundColor = .white
        editBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(200)
        }
        
        navigationController?.navigationBar.lt_setBackgroundColor(UIColor.clear)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "", style: .done, target: nil, action: nil)
        view.addSubview(captureView)
        
//        
//        let bottomLay = CALayer()
//        bottomLay.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
//        bottomLay.bounds = CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: 30)
//        bottomLay.position = CGPoint(x: 0, y: UIConst.screenHeight - 200.0 - 30.0)
//        bottomLay.anchorPoint = CGPoint(x: 0, y: 0)
//        view.layer.addSublayer(bottomLay)
    }
    
    private func response(){
        
        editBar.nextClosure = {
            print("点击了下一步")
        }
        
        editBar.cancleClosure = {
            print("点击了取消")
            self.navigationController?.popViewController(animated: true)
        }
        
        editBar.rotateClosure = {
            print("点击了旋转")
        }
    }
    
}
