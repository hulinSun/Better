//
//  HotRecommondCell.swift
//  better
//
//  Created by Hony on 2016/11/7.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class HotRecommondCell: UITableViewCell{

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    /// 闭包走一波
    
    enum HotBntType {
        case comment
        case zan
        case retweet
        case more
    }
    
    
    /// 点击按钮的闭包
    typealias hotClickClosure = (_ hotCell: HotRecommondCell, _ model: SinglePrdHotRecommond, _ type: HotBntType)-> Void
    
     var clickClosure: hotClickClosure?
    
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
         i.textColor = UIColor.init(hexString: "666666")
        return i
    }()
    
    /// 底部留白线
    fileprivate lazy var gapLine: UIView = {
        let i = UIView()
        i.backgroundColor = UIColor.init(hexString: "f4f4f4")
        return i
    }()
    
    /// 喜欢
    fileprivate lazy var likeBtn: UIButton = {
        let i = UIButton()
        i.setTitleColor(UIColor.lightGray, for: .normal)
        i.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        i.setImage(UIImage(named:"community_like"), for: .normal)
        i.titleEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        i.contentHorizontalAlignment = .left
        return i
    }()
    
    /// 多少人评论label
    fileprivate lazy var commentCountLabel: UILabel = {
        let i = UILabel()
        i.text = "快去评论一个吧"
        i.font = UIFont.systemFont(ofSize: 12)
        i.textColor = UIColor.rgb(red: 150, green: 150, blue: 150)
        return i
    }()
    
    /// 留言数组
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
//            prar.lineSpacing = 4
            let attr = NSMutableAttributedString(string:
                (recommond?.content)!, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 13) , NSForegroundColorAttributeName : UIColor.rgb(red: 150, green: 150, blue: 150) , NSParagraphStyleAttributeName: prar])
            descLabel.attributedText = attr
            likeBtn.setTitle( (recommond?.dynamic?.likes)! + "人喜欢", for: .normal)
            
            if let commentCount = recommond?.comments?.count ,commentCount > 0{
                commentCountLabel.text = "所有" + "\(commentCount)" + "条评论"
            }else{
                commentCountLabel.text = "评论"
            }
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
                let l = UILabel()
                l.numberOfLines = 0
                l.preferredMaxLayoutWidth = UIConst.screenWidth - 20
                let com = coms[i]
                let str = com.nickname! + ": " + com.conent!
                let attr = NSMutableAttributedString(string: str, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName:UIColor.rgb(red: 109, green: 109, blue: 109)])
                let range = (str as NSString).range(of: (com.nickname! + ": "))
                
                attr.addAttributes([NSForegroundColorAttributeName:UIColor.rgb(red: 91, green: 159, blue: 189)], range: range)
                l.attributedText = attr
                commentView.addSubview(l)
                items.append(l)
            }
        }
    }
    
    fileprivate func setupUI(){
        backgroundColor = .white
        contentView.addSubview(topView)
        topView.delegate = self
        contentView.addSubview(descLabel)
        contentView.addSubview(likeBtn)
        contentView.addSubview(commentCountLabel)
        contentView.addSubview(commentView)
        topView.backgroundColor = .white
        contentView.addSubview(hotInputView)
        contentView.addSubview(gapLine)
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
            make.width.equalTo(150)
        }
        
        commentCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(likeBtn)
            make.top.equalTo(likeBtn.snp.bottom)
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
                    make.top.equalTo((items.first?.snp.bottom)!).offset(5)
                }else if i == 2{
                    make.top.equalTo(items[1].snp.bottom).offset(5)
                }
            })
        }
        
        if (recommond?.comments?.count)! > 0 {
            commentView.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(commentCountLabel.snp.bottom).offset(10)
                make.bottom.equalTo((commentView.subviews.last?.snp.bottom)!).offset(5).priority(751)
            }
        }
        
        hotInputView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(54)
            if(recommond?.comments?.count)! > 0{
                make.top.equalTo(commentView.snp.bottom).priority(751)
            }else{
                make.top.equalTo(commentCountLabel.snp.bottom).priority(249)
            }
        }
        
        gapLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(10)
            make.top.equalTo(hotInputView.snp.bottom)
        }
    }
    
    deinit {
        print("dealloc")
    }
    
}


extension HotRecommondCell: HotTopViewProtocol{
    
    func hotTopViewclickZanButton(){
        print("我知道了赞 ")
        clickClosure?(self, recommond!, .zan)
    }
    func hotTopViewclickCommentButton(){
        print("我知道了品论 ")
        clickClosure?(self, recommond!, .comment)
    }
    func hotTopViewclickMoreButton(){
        print("我知道了genduo ")
        clickClosure?(self, recommond!, .more)
    }
    func hotTopViewclickRetweetButton(){
        print("我知道了战法 ")
        clickClosure?(self, recommond!, .retweet)
    }
}
