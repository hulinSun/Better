//
//  PhotoGroupCell.swift
//  better
//
//  Created by Hony on 2016/11/22.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import Photos

class PhotoGroupCell: UITableViewCell {

    var item: PhotoGroupItem?{
        didSet{
            let count = (item?.count)!
            nameLabel.text = (item?.name)! + " ("+"\(count)"+")张"
          
            if let firstImage = item?.firstImg{
                let opt = PHImageRequestOptions()
                opt.deliveryMode = .highQualityFormat
                PHCachingImageManager.default().requestImage(for: firstImage, targetSize: CGSize(width: 54, height: 54), contentMode: .aspectFit, options: opt, resultHandler: { (img , info) in
                    self.iconView.image = img
                })
            }else{
                self.iconView.backgroundColor = UIColor.random()
            }
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
