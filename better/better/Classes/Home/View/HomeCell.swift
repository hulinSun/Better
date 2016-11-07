//
//  HomeCell.swift
//  better
//
//  Created by Hony on 2016/11/3.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import Kingfisher

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!{ /// 头像
        didSet{
            iconView.layer.cornerRadius = 15
            iconView.clipsToBounds = true
            iconView.layer.borderColor = UIColor.white.cgColor
            iconView.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var smallconView: UIImageView!
    @IBOutlet weak var originView: UIImageView! /// 是否是原创
    @IBOutlet weak var nameLabel: UILabel! /// 姓名
    @IBOutlet weak var picview: UIImageView! /// 大图片
    @IBOutlet weak var titleView: UILabel! /// 标题
    @IBOutlet weak var subTitleView: UILabel! /// 下面的浏览数
    
    var topic: Topic?{
        didSet{
            picview.kf.setImage(with: URL(string: (topic?.pic)!))
            titleView.text = topic?.title!
            if topic?.user?.avatar != nil {
                iconView.kf.setImage(with:  URL(string: (topic?.user?.avatar)!))
            }
            nameLabel.text = topic?.user?.nickname ?? "匿名"
            if let show = topic?.is_show_like , show == true{
                smallconView.image = UIImage(named: "home_likes_dark_icon")
                subTitleView.text = topic?.likes!
            }else{
                smallconView.image = UIImage(named: "home_article_view_dark_icon")
                subTitleView.text = topic?.views!
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    
}
