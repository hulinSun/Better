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
            CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: UIConst.screenHeight - 210.0))
        return i
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        response()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.lt_reset()
    }
    var photoSize: CGSize!{
        didSet{
            captureView.contSize = photoSize
        }
    }
    
    var img: UIImage!{
        didSet{
            captureView.img = img
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(editBar)
        editBar.backgroundColor = .white
        editBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(210)
        }
        
        //FIXME: 日你奶奶
        navigationController?.navigationBar.lt_setBackgroundColor(UIColor.clear)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "", style: .done, target: nil, action: nil)
        view.addSubview(captureView)
    
        let topLayer = CALayer()
        topLayer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
        topLayer.bounds = CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: 40)
        topLayer.position = CGPoint(x: 0, y: 0)
        topLayer.anchorPoint = CGPoint(x: 0, y: 0)
        view.layer.addSublayer(topLayer)
        
        let bottomLay = CALayer()
        bottomLay.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
        bottomLay.bounds = CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: 40)
        bottomLay.position = CGPoint(x: 0, y: UIConst.screenHeight - 210.0 - 40.0)
        bottomLay.anchorPoint = CGPoint(x: 0, y: 0)
        view.layer.addSublayer(bottomLay)
    }
    
    
    private func response(){
        
        editBar.nextClosure = { [unowned self] in
            print("点击了下一步")
            let filterVC = PhotoFilterController()
            self.navigationController?.pushViewController(filterVC, animated: true)
        }
        
        editBar.cancleClosure = {
            print("点击了取消")
           let _ = self.navigationController?.popViewController(animated: true)
        }
        
        editBar.rotateClosure = {
            print("点击了旋转")
            UIView.animate(withDuration: 0.25, animations: { 
                self.captureView.transform = self.captureView.transform.rotated(by: CGFloat.pi * 0.5);
            })
        }
    }
    
}
