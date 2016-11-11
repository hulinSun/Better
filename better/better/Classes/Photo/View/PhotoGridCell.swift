//
//  PhotoGridCell.swift
//  better
//
//  Created by Hony on 2016/11/10.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class PhotoGridCell: UICollectionViewCell {
    
    typealias GridCellClickImageClosure = (_ cell: PhotoGridCell, _ indexPath: IndexPath)-> Void
    
    var clickClosure: GridCellClickImageClosure?
    
    fileprivate lazy var imgView: UIImageView = {
        let i = UIImageView()
        i.layer.cornerRadius = 3
        i.clipsToBounds = true
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        i.isUserInteractionEnabled = true
        return i
    }()
    
    fileprivate lazy var iconView: UIImageView = {
        let i = UIImageView(image: UIImage(named: "BoAssetsPickerChecked"))
        i.isUserInteractionEnabled = false
        i.isHidden = true
        return i
    }()
    
    /// 是否被选中
    var isChoosed: Bool = false{
        didSet{
            if isChoosed == true {
                iconView.isHidden = false
            }else{
                iconView.isHidden = true
            }
        }
    }
    
    var isCamera: Bool = false{
        didSet{
            if isCamera == true {
                imgView.image = UIImage(named: "BoAssetsCamera")
            }else{
              imgView.image = img
            }
        }
    }
    
    var indexPath: IndexPath?
    
    var img: UIImage?{
        didSet{
            imgView.image = img
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    /// 这里点击了图片，collection 的点击代理方法不走了。因为方法在这里相应了。没有往下个响应者传下。所以这里需要通过代理或者闭包传出去
    func tapImage() {
        clickClosure?(self, indexPath!)
    }
    
    private func setupUI() {
        backgroundColor = .white
        contentView.addSubview(imgView)
        imgView.addSubview(iconView)
        
        imgView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(2.5)
            make.bottom.right.equalToSuperview().offset(-2.5)
        }
        iconView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.bottom.right.equalToSuperview().offset(-5)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        imgView.addGestureRecognizer(tap)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
