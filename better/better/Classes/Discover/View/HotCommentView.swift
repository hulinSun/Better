//
//  HotCommentView.swift
//  better
//
//  Created by Hony on 2016/11/8.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class HotCommentView: UIView {
    
    /// 喜欢
    fileprivate lazy var likeBtn: UIButton = {
        let i = UIButton()
        return i
    }()
    
    /// 多少人评论label
    fileprivate lazy var commentCountLabel: UILabel = {
        let i = UILabel()
        return i
    }()
    
    
    fileprivate lazy var items: [UILabel] = {
        let i = Array<UILabel>()
        return i
    }()
    
    var recommond: SinglePrdHotRecommond?{
        didSet{
            items.forEach{$0.removeFromSuperview()}
            items.removeAll()
            if let coms = recommond?.comments{
                for i in 0..<coms.count {
                    // 创建一个label
                    let l = UILabel()
                    items.append(l)
                    l.backgroundColor = UIColor.random()
                    l.tag = i
                    l.numberOfLines = 0
                    l.preferredMaxLayoutWidth = UIConst.screenWidth - 20
                    
                    l.snp.makeConstraints({ (make) in
                        make.left.right.equalToSuperview()
                        if i == 0 {
                            make.top.equalToSuperview()
                        }else if i == 1{
                            make.top.equalTo((items.first?.snp.bottom)!)
                        }else if i == 2{
                            make.top.equalTo(items[1].snp.bottom)
                        }
                    })
                }
            }
        }
    }
    
//    init(frame: CGRect ,recommond:SinglePrdHotRecommond? ) {
//        super.init(frame: frame)
//        setupUI()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 初始化
    fileprivate func setupUI(){
        addSubview(likeBtn)
        addSubview(commentCountLabel)
        
        likeBtn.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
            make.height.equalTo(20)
            make.width.lessThanOrEqualTo(100)
        }
        commentCountLabel.snp.makeConstraints { (make) in
            make.left.height.equalTo(likeBtn)
            make.top.equalTo(likeBtn.snp.bottom).offset(5)
            make.width.lessThanOrEqualTo(100)
        }
    }
}






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
