//
//  HotTopView.swift
//  better
//
//  Created by Hony on 2016/11/7.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit





class HotInputView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var leftIcon: UIImageView = {
        let i = UIImageView()
        i.contentMode = .center
        return i
    }()
    
    fileprivate lazy var rightBg: UIImageView = {
        let i = UIImageView()
        return i
    }()
    
    /// 初始化
    fileprivate func setupUI(){
        addSubview(leftIcon)
        addSubview(rightBg)
        
        leftIcon.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(30)
        }
        
        rightBg.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(leftIcon.snp.right)
        }
    }
    
}


class HotTopView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    var recommond: SinglePrdHotRecommond?{
        didSet{
           iconView.kf.setImage(with: URL(string: (recommond?.author?.avatar)!))
            nameLabel.text = recommond?.author?.nickname
            dateLabel.text = recommond?.create_time
            imgView1.kf.setImage(with: URL(string: (recommond?.pics?.first?.url)!))
        }
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
        addSubview(line)
        
//        iconView.backgroundColor = .red
//        nameLabel.backgroundColor = .blue
//        vipView.backgroundColor = .yellow
//        dateLabel.backgroundColor = .green
//        picScrollView.backgroundColor = UIColor.random()
//        pageControll.backgroundColor = UIColor.random()
//        commentBtn.backgroundColor = UIColor.random()
//        moreBtn.backgroundColor = UIColor.random()
//        zanBtn.backgroundColor = UIColor.random()
//        retweetBtn.backgroundColor = UIColor.random()
        
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
            make.width.lessThanOrEqualTo(200)
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
            make.right.equalToSuperview().offset(-20)
        }
        
        picScrollView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(54)
            make.height.equalTo(190)
        }
        
        commentBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 34, height: 34))
            make.top.equalTo(picScrollView.snp.bottom).offset(7)
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
        
        line.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(0.5)
            make.top.equalTo(moreBtn.snp.bottom).offset(4)
        }
        
        imgView1.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
    }
    
    //MARL: - 懒加载
    
    /// 头像
    fileprivate lazy var iconView: UIImageView = {
        let i = UIImageView()
        i.layer.cornerRadius = 17
        i.clipsToBounds = true
        return i
    }()
    
    fileprivate lazy var line: UIImageView = {
        let i = UIImageView()
        i.alpha = 0.7
        i.image = UIImage(named:"line_article_edit")
        return i
    }()
    
    /// 姓名
    fileprivate lazy var nameLabel: UILabel = {
        let i = UILabel()
        i.text = "程冠希"
        i.font = UIFont.systemFont(ofSize: 14)
        i.textColor = UIColor.init(hexString: "666666")
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
        i.font = UIFont.systemFont(ofSize: 12)
        i.textColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        return i
    }()
    
    /// 图片的scrollview
    fileprivate lazy var picScrollView: UIScrollView = {
        let i = UIScrollView()
        i.showsVerticalScrollIndicator = false
        i.showsHorizontalScrollIndicator = false
        i.isScrollEnabled = false
        i.addSubview(self.imgView1)
        return i
    }()
    
    /// 评论按钮
    fileprivate lazy var commentBtn: UIButton = {
        let i = UIButton()
        i.setImage(UIImage(named: "btn_group_comment"), for: .normal)
        return i
    }()
    
    /// 赞按钮
    fileprivate lazy var zanBtn: UIButton = {
        let i = UIButton()
        i.setImage(UIImage(named: "btn_group_like"), for: .normal)
        return i
    }()
    
    /// 转发按钮
    fileprivate lazy var retweetBtn: UIButton = {
        let i = UIButton()
        i.setImage(UIImage(named: "btn_topic_share_gray"), for: .normal)
        return i
    }()
    
    /// 更多按钮
    fileprivate lazy var moreBtn: UIButton = {
        let i = UIButton()
        i.setImage(UIImage(named: "btn_group_more"), for: .normal)
        return i
    }()
    
    /// pagecontrol
    fileprivate lazy var pageControll: UIPageControl = {
        let i = UIPageControl()
        return i
    }()
    
    
    fileprivate lazy var imgView1: UIImageView = {
        let i = UIImageView()
        i.contentMode = .center
        return i
    }()
    
    
    fileprivate lazy var imgView2: UIPageControl = {
        let i = UIPageControl()
        return i
    }()  
}



extension HotTopView {
    
    
}
