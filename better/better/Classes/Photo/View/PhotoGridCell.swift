//
//  PhotoGridCell.swift
//  better
//
//  Created by Hony on 2016/11/10.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class PhotoGridCell: UICollectionViewCell {
    
    
    fileprivate lazy var imgView: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        return i
    }()
    
    var img: UIImage?{
        didSet{
            imgView.image = img
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
