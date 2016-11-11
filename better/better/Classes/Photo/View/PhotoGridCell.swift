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
        i.layer.cornerRadius = 3
        i.clipsToBounds = true
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
        backgroundColor = .white
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(2.5)
            make.bottom.right.equalToSuperview().offset(-2.5)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
