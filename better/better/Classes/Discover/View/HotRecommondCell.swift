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
    
    /// 评论
    fileprivate lazy var commentView: UIView = {
        let i = UIView()
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
    
    
    /// 喜欢
    fileprivate lazy var likeBtn: UIButton = {
        let i = UIButton()
        i.setTitleColor(UIColor.lightGray, for: .normal)
        i.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return i
    }()
    
    /// 多少人评论label
    fileprivate lazy var commentCountLabel: UILabel = {
        let i = UILabel()
        i.text = "评论"
        i.font = UIFont.systemFont(ofSize: 13)
        i.textColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        return i
    }()
    
    
    fileprivate lazy var items: [UILabel] = {
        let i = Array<UILabel>()
        return i
    }()
    
    
    /// 输入框
    fileprivate lazy var hotInputView: HotInputView = {
        let i = HotInputView()
        return i
    }()
    
    
    var recommond: SinglePrdHotRecommond?{
        didSet{
            topView.recommond = recommond
            let prar = NSMutableParagraphStyle()
            prar.lineSpacing = 4
            let attr = NSMutableAttributedString(string:
                (recommond?.content)!, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 13) , NSForegroundColorAttributeName : UIColor.rgb(red: 150, green: 150, blue: 150) , NSParagraphStyleAttributeName: prar])
            descLabel.attributedText = attr
            likeBtn.setTitle( (recommond?.dynamic?.likes)! + "人喜欢", for: .normal)
            addCommentView()
            setNeedsLayout()
        }
    }
    
    
    fileprivate func addCommentView(){
        if items.isEmpty == false {
            items.forEach{$0.removeFromSuperview()}
            items.removeAll()
        }
        
        if let coms = recommond?.comments{
            for i in 0..<coms.count {
                // 创建一个label
                let l = UILabel()
                l.font = UIFont.systemFont(ofSize: 13)
                l.textColor = UIColor.rgb(red: 140, green: 140, blue: 140)
                l.backgroundColor = UIColor.random()
                l.numberOfLines = 0
                l.preferredMaxLayoutWidth = UIConst.screenWidth - 20
                l.text = coms[i].conent
                commentView.addSubview(l)
                items.append(l)
            }
        }
    }
    
    fileprivate func setupUI(){
//        backgroundColor = UIColor.init(hexString: "f4f4f4")
        backgroundColor = .white
        contentView.addSubview(topView)
        contentView.addSubview(descLabel)
        contentView.addSubview(likeBtn)
        contentView.addSubview(commentCountLabel)
        contentView.addSubview(commentView)
        commentView.backgroundColor = UIColor.random()
        topView.backgroundColor = .white
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
        
        likeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(descLabel)
            make.top.equalTo(descLabel.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.width.lessThanOrEqualTo(100)
        }
        
        commentCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(likeBtn)
            make.top.equalTo(likeBtn.snp.bottom).offset(5)
            make.width.lessThanOrEqualTo(200)
            make.height.equalTo(17)
        }
       
        
        for i in 0..<items.count{
            let l = items[i]
            l.snp.makeConstraints({ (make) in
                make.left.equalToSuperview().offset(10)
                make.right.equalToSuperview().offset(-10)
                if i == 0 {
                    make.top.equalToSuperview().offset(5)
                }else if i == 1{
                    make.top.equalTo((items.first?.snp.bottom)!)
                }else if i == 2{
                    make.top.equalTo(items[1].snp.bottom)
                }
            })
        }
        
        if (recommond?.comments?.count)! > 0 {
            commentView.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(commentCountLabel.snp.bottom).offset(10)
                make.bottom.equalTo((commentView.subviews.last?.snp.bottom)!)
            }
        }
        
    }
}
