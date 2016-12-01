//
//  PhotoFilterCell.swift
//  better
//
//  Created by Hony on 2016/11/30.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import GPUImage

class PhotoItemButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        
        setTitleColor(UIColor.lightGray, for: .normal)
        setTitleColor(UIConst.themeColor, for: .selected)
        imageView?.contentMode = .center
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        imageEdgeInsets = UIEdgeInsetsMake(-25, 0, 0, 0)
        titleEdgeInsets = UIEdgeInsetsMake(35, -50, 0, 0)
    }
    
//    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
//        return CGRect(x: 0, y: contentRect.height * 0.6, width: contentRect.width, height: contentRect.height * 3)
//    }
//    
//    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
//        return CGRect(x: 0, y: 0, width: contentRect.width, height: contentRect.height * 0.6)
//    }
    
}

struct FiltItem {
    var img: UIImage
    var name: String
}

class PhotoFilterCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!{
        didSet{
            nameLabel.textColor = UIColor.rgb(red: 110, green: 110, blue: 110)
        }
    }
    @IBOutlet weak var iconView: UIImageView!{
        didSet{
            iconView.layer.cornerRadius = 2
            iconView.clipsToBounds = true
            iconView.contentMode = .scaleAspectFill
            iconView.backgroundColor = UIColor.random()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var item: FiltItem?{
        didSet{
            iconView.image = item?.img
            nameLabel.text = item?.name
        }
    }

}
