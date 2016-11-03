//
//  DiscoverArticleCell.swift
//  better
//
//  Created by Hony on 2016/10/28.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import Kingfisher

class DiscoverArticleCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    @IBOutlet weak var commentView: UIButton!
    @IBOutlet weak var scanView: UIButton!
    
    @IBOutlet weak var pictureView: UIImageView!{
        didSet{
            pictureView.backgroundColor = UIColor.rgb(red: 246, green: 246, blue: 246)
            pictureView.layer.cornerRadius = 2
            pictureView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var descTitle: UILabel!
    @IBOutlet weak var smallIcon: UIImageView!{
        didSet{
            smallIcon.layer.cornerRadius = 9
            smallIcon.clipsToBounds = true
        }
    }
    @IBOutlet weak var autoLabel: UILabel!
    
    var topic: Topic?{
        didSet{
            topTitle.text = topic?.title!
             topTitle.text = topic?.title!
             descTitle.text = topic?.desc!
            commentView.setTitle(topic?.comments, for: .normal)
            scanView.setTitle(topic?.views, for: .normal)
            autoLabel.text = (topic?.order_time_str)! + " | " + (topic?.user?.nickname)!
            smallIcon.kf.setImage(with: URL(string: (topic?.user?.avatar)!))
            if let rightIcon = topic?.pics.first?.url{
                pictureView.kf.setImage(with: URL(string: rightIcon))
            }
        }
    }
}
