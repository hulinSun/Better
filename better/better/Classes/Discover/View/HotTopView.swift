//
//  HotTopView.swift
//  better
//
//  Created by Hony on 2016/11/7.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class HotTopView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI(){
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(vipView)
        addSubview(dateLabel)
        addSubview(picScrollView)
        addSubview(pageControll)
        addSubview(commentBtn)
        addSubview(zanBtn)
        addSubview(retweetBtn)
        addSubview(moreBtn)
        
    }
    
    //MARL: - 懒加载
    
    /// 头像
    fileprivate lazy var iconView: UIImageView = {
        let i = UIImageView()
        return i
    }()
    
    /// 姓名
    fileprivate lazy var nameLabel: UILabel = {
        let i = UILabel()
        return i
    }()
    
    /// 右边黄色小叶子
    fileprivate lazy var vipView: UIImageView = {
        let i = UIImageView()
        return i
    }()
    
    /// 日期
    fileprivate lazy var dateLabel: UILabel = {
        let i = UILabel()
        return i
    }()
    
    /// 图片的scrollview
    fileprivate lazy var picScrollView: UIScrollView = {
        let i = UIScrollView()
        return i
    }()
    
    /// 评论按钮
    fileprivate lazy var commentBtn: UIButton = {
        let i = UIButton()
        return i
    }()
    
    /// 赞按钮
    fileprivate lazy var zanBtn: UIButton = {
        let i = UIButton()
        return i
    }()
    
    /// 转发按钮
    fileprivate lazy var retweetBtn: UIButton = {
        let i = UIButton()
        return i
    }()
    
    /// 更多按钮
    fileprivate lazy var moreBtn: UIButton = {
        let i = UIButton()
        return i
    }()
    
    /// pagecontrol
    fileprivate lazy var pageControll: UIPageControl = {
        let i = UIPageControl()
        return i
    }()
    
}



extension HotTopView {
    
    
}
