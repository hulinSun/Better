//
//  DiscoverViewController.swift
//  better
//
//  Created by Hony on 2016/10/13.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate lazy var editItem: UIBarButtonItem = {
        let i =  UIBarButtonItem.itemWith(icon: "discover_write_article_icon", highlightIcon: "discover_write_article_icon", target: self, action: #selector(DiscoverViewController.edit))
        return i
    }()
    
    fileprivate lazy var takePhotoItem: UIBarButtonItem = {
        let i =  UIBarButtonItem.itemWith(icon: "discovey_camera_btn", highlightIcon: "discovey_camera_btn", target: self, action: #selector(DiscoverViewController.takePhoto))
        return i
    }()

    
    fileprivate var titleV: DiscoverTitleView!
  
    
    private func setupUI() {
        configNav()
    }
}

// MARK: - configNav
extension DiscoverViewController{
    
   fileprivate func findHairlineImageViewUnder(view: UIView) -> UIImageView? {
        if view is UIImageView && (view.height <= 1.0) {
            return view as? UIImageView
        }
        for subView in view.subviews{
            guard let img = findHairlineImageViewUnder(view: subView) else{
                return nil
            }
            return img
        }
        return nil
    }
    
    /// 初始化导航栏
    fileprivate func configNav() {
        
        navigationItem.rightBarButtonItem = editItem
        let leftItem = UIBarButtonItem.itemWithBack(icon: "discover_article_list_dark_icon", highlightIcon: "discover_article_list_icon", target: self, action: #selector(DiscoverViewController.leftClick))
        navigationItem.leftBarButtonItem = leftItem
        
        if let hairl = findHairlineImageViewUnder(view: navigationController!.navigationBar){
            hairl.isHidden = true
        }
        
        let v = DiscoverTitleView.discoverTitleView()
        v.clickItemback = { [weak self] item in
            switch item {
            case .left: self?.navigationItem.rightBarButtonItem = self?.editItem
            case .right: self?.navigationItem.rightBarButtonItem = self?.takePhotoItem
            }
        }
        v.width = 100 ; v.height = 44
        navigationItem.titleView = v ; titleV = v
    }
    
    func edit() {
       print("点击了编辑按钮")
    }
    
    func leftClick()  {
        print("点击了菜单按钮")
    }
    
    func takePhoto()  {
        print("照相")
    }
    
}


