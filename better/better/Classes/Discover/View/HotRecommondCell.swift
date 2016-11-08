//
//  HotRecommondCell.swift
//  better
//
//  Created by Hony on 2016/11/7.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class HotRecommondCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 头部
    fileprivate lazy var topView: HotTopView = {
        let i = HotTopView()
        return i
    }()
    
    /// 描述
    fileprivate lazy var descLabel: UILabel = {
        let i = UILabel()
        i.numberOfLines = 0
        i.preferredMaxLayoutWidth = UIConst.screenWidth
        return i
    }()
    
    /// 评论
    fileprivate lazy var commentView: HotCommentView = {
        let i = HotCommentView()
        return i
    }()
    
    /// 输入框
    fileprivate lazy var hotInputView: HotInputView = {
        let i = HotInputView()
        return i
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lay()
    }
    
    
    var recommond: SinglePrdHotRecommond?{
        didSet{
            lay()
        }
    }
    
    
    fileprivate func setupUI(){
        
        contentView.addSubview(topView)
        contentView.addSubview(descLabel)
//        contentView.addSubview(commentView)
//        contentView.addSubview(hotInputView)
        topView.backgroundColor = UIColor.random()
        lay()
    }
    
    
    
    fileprivate func lay(){
        
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
        }
        
//        commentView.snp.makeConstraints { (make) in
//            make.top.equalTo(descLabel.snp.bottom).offset(15)
//            make.left.right.equalToSuperview()
//            make.bottom.equalTo((commentView.subviews.last?.snp.bottom)!)
//        }
//        
//        hotInputView.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(commentView.snp.bottom)
//            make.height.equalTo(44)
//        }

    }
}
