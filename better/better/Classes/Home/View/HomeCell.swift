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
        }
    }
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
            subTitleView.text = topic?.views!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    
}
