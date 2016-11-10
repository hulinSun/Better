//
//  TopCategoryCell.swift
//  better
//
//  Created by Hony on 2016/11/7.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import Kingfisher

class TopCategoryCell: UICollectionViewCell {

    @IBOutlet weak var botLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bgImgView: UIImageView!{
        didSet{
            bgImgView.layer.cornerRadius = 3
            bgImgView.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var item: SingleProCategoryItem?{
        didSet{
            topLabel.text = item?.name
            botLabel.text = item?.en_name
            let url = URL(string: (item?.pic)!)
            bgImgView.kf.setImage(with: url)
        }
    }
}
