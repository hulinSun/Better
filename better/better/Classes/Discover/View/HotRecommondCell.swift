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
        i.backgroundColor = .white
        i.numberOfLines = 0
        i.preferredMaxLayoutWidth = UIConst.screenWidth - 20
        i.font = UIFont.systemFont(ofSize: 13)
        i.textColor = UIColor.rgb(red: 150, green: 150, blue: 150)
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
            topView.recommond = recommond
            let prar = NSMutableParagraphStyle()
            prar.lineSpacing = 4
            let attr = NSMutableAttributedString(string:
                (recommond?.content)!, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 13) , NSForegroundColorAttributeName : UIColor.rgb(red: 150, green: 150, blue: 150) , NSParagraphStyleAttributeName: prar])
            descLabel.attributedText = attr
            commentView.recommond = recommond
            setNeedsLayout()
        }
    }
    
    
    fileprivate func setupUI(){
//        backgroundColor = UIColor.init(hexString: "f4f4f4")
        backgroundColor = .white
        contentView.addSubview(topView)
        contentView.addSubview(descLabel)
        contentView.addSubview(commentView)
        commentView.backgroundColor = UIColor.random()
//        contentView.addSubview(hotInputView)
        topView.backgroundColor = .white
        lay()
    }
    
    
    
    fileprivate func lay(){
        
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(295)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(topView.snp.bottom).offset(10)
        }
        
        commentView.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            
            if let i = commentView.subviews.last{
                print((i as! UILabel).text)
                make.bottom.equalTo(i.snp.bottom).offset(0)
            }
//            make.height.equalTo(120)
//        make.bottom.equalTo((commentView.subviews.last?.snp.bottom)!)
            
        }

//        hotInputView.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview()
//            make.top.equalTo(commentView.snp.bottom)
//            make.height.equalTo(44)
//        }

    }
}
