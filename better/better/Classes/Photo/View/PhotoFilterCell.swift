//
//  PhotoFilterCell.swift
//  better
//
//  Created by Hony on 2016/11/30.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class PhotoFilterCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var iconView: UIImageView!{
        didSet{
            iconView.layer.cornerRadius = 2
            iconView.clipsToBounds = true
            iconView.backgroundColor = UIColor.random()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
