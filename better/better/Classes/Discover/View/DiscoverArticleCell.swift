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
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var descTitle: UILabel!
    @IBOutlet weak var smallIcon: UIImageView!
    @IBOutlet weak var autoLabel: UILabel!
    
    var topic: Topic?{
        didSet{
            
            print(topic?.title)
            topTitle.text = topic?.title!
            /**
             topTitle.text = topic?.title!
             descTitle.text = topic?.desc!
            
            pictureView.kf.setImage(with: URL(string: topic!.pic!))
            commentView.setTitle(topic?.comments, for: .normal)
            scanView.setTitle(topic?.views, for: .normal)
            autoLabel.text = topic?.update_time + "|" + ""
            smallIcon.kf.setImage(with: URL(string: topic?.user?.avatar))*/
        }
    }
    
}
