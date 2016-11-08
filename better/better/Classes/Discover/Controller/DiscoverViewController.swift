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

    
    fileprivate lazy var articleVC: DiscoverArticleController = {
        let i = DiscoverArticleController()
        return i
    }()
    
    fileprivate lazy var singleVC: DiscoverSingleController = {
        let i = DiscoverSingleController()
        return i
    }()
    
    fileprivate var titleV: DiscoverTitleView!
  
    
    private func setupUI() {
        configNav()
        
        // 添加子控制器
        addChildViewController(articleVC)
        view.addSubview(articleVC.view)
        addChildViewController(singleVC)
        view.addSubview(singleVC.view)
        singleVC.view.isHidden = true
        
        
    }
}

// MARK: - configNav
extension DiscoverViewController{
    
   fileprivate func findHairlineImageViewUnder(view: UIView) -> UIImageView? {
        if view is UIImageView && (view.bt_height <= 1.0) {
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
                self?.articleVC.view.isHidden = false
                self?.singleVC.view.isHidden = true
            case .right: self?.navigationItem.rightBarButtonItem = self?.takePhotoItem
                self?.singleVC.view.isHidden = false
                self?.articleVC.view.isHidden = true
            }
        }
        v.bt_width = 100 ; v.bt_height = 44
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


