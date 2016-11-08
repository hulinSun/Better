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
        
        iconView.backgroundColor = .red
        nameLabel.backgroundColor = .blue
        vipView.backgroundColor = .yellow
        dateLabel.backgroundColor = .green
        picScrollView.backgroundColor = UIColor.random()
        pageControll.backgroundColor = UIColor.random()
        commentBtn.backgroundColor = UIColor.random()
        moreBtn.backgroundColor = UIColor.random()
        zanBtn.backgroundColor = UIColor.random()
        retweetBtn.backgroundColor = UIColor.random()
        
        // 头像
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.size.equalTo(CGSize(width: 34, height: 34))
        }
        
        
        // 昵称
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.centerY.equalTo(iconView)
            make.height.equalTo(17)
            make.width.lessThanOrEqualTo(50)
        }
        
        // vip
        vipView.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconView)
            make.left.equalTo(nameLabel.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        /// 日期
        dateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconView)
            make.width.lessThanOrEqualTo(100)
            make.height.equalTo(16)
            make.right.equalToSuperview().offset(20)
        }
        
        picScrollView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(54)
            make.height.equalTo(190)
        }
        
        commentBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 34, height: 34))
            make.top.equalTo(picScrollView.snp.bottom).offset(10)
        }
        
        zanBtn.snp.makeConstraints { (make) in
            make.size.equalTo(commentBtn)
            make.centerY.equalTo(commentBtn)
            make.left.equalTo(commentBtn.snp.right).offset(10)
        }
        
        retweetBtn.snp.makeConstraints { (make) in
            make.size.equalTo(commentBtn)
            make.centerY.equalTo(commentBtn)
            make.left.equalTo(zanBtn.snp.right).offset(10)
        }
        
        moreBtn.snp.makeConstraints { (make) in
            make.size.equalTo(commentBtn)
            make.centerY.equalTo(commentBtn)
            make.right.equalToSuperview().offset(-10)
        }
        
        
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
        i.text = "程冠希"
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
        i.text = "1993.23.34"
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
