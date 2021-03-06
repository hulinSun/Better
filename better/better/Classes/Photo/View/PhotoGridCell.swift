//
//  PhotoGridCell.swift
//  better
//
//  Created by Hony on 2016/11/10.
//  Copyright © 2016年 Hony. All rights reserved.
//

import Photos
import UIKit


class PhotoTitleView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named: "btn_brand_product_arrow_down"), for: .normal)
        setImage(UIImage(named: "btn_brand_product_arrow_down"), for: .highlighted)
        adjustsImageWhenHighlighted = true
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel?.textAlignment = .center
        imageView?.contentMode = .center
        setTitleColor(UIColor.rgb(red: 100, green: 100, blue: 100), for: .normal)
        
    }
    
    override var intrinsicContentSize: CGSize
        {
        let su = super.intrinsicContentSize
        return CGSize(width: su.width + 15, height: su.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: contentRect.size.width - 18, height: contentRect.height)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: contentRect.width  - 18, y: 0, width: 8, height: contentRect.height)
    }
}

class PhotoGridCell: UICollectionViewCell {
    static let tgSize: CGSize = CGSize(width: ((UIConst.screenWidth - 5) / 3.0) * (UIConst.screenScale), height: ((UIConst.screenWidth - 5 ) / 3.0) * (UIConst.screenScale))
    fileprivate lazy var opt: PHImageRequestOptions = {
        let i = PHImageRequestOptions()
        i.deliveryMode = .highQualityFormat
        return i
    }()
    typealias GridCellClickImageClosure = (_ cell: PhotoGridCell, _ indexPath: IndexPath)-> Void
    
    var clickClosure: GridCellClickImageClosure?
    
    fileprivate lazy var imgView: UIImageView = {
        let i = UIImageView()
        i.layer.cornerRadius = 2
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
    
    var item: GridItem?{
        didSet{
            if (item?.choosed)! == true{
                iconView.isHidden = false
            }else{
                iconView.isHidden = true
            }
            
            if item?.isCarmea == true{
                imgView.image = UIImage(named: "BoAssetsCamera")
            }else{
                if let aset = item?.asset{
                    PHCachingImageManager.default().requestImage(for: aset, targetSize: PhotoGridCell.tgSize, contentMode: .default, options: opt, resultHandler: { (img , info) in
                        self.imgView.image = img
                    })
                }
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    /// 这里点击了图片，collection 的点击代理方法不走了。因为方法在这里相应了。没有往下个响应者传下。所以这里需要通过代理或者闭包传出去
    func tapImage( recon: UITapGestureRecognizer) {
        let clickPoint = recon.location(in: recon.view)
        
        clickClosure?(self, (self.item?.indexPath)!)
        tapAnimate(point: clickPoint)
    }
    
    private func tapAnimate(point: CGPoint){
        if self.item?.indexPath?.item == 0 { return }
        let clickLayer = CALayer()
        clickLayer.backgroundColor = UIColor.white.cgColor
        clickLayer.masksToBounds = true
        clickLayer.cornerRadius = 3
        clickLayer.frame = CGRect(x: 0, y: 0, width: 6, height: 6)
        clickLayer.position = point
        clickLayer.opacity = 0.3
        clickLayer.name = "clickLayer"
        imgView.layer.addSublayer(clickLayer)
        
        let zoom = CABasicAnimation.init(keyPath: "transform.scale")
        zoom.toValue = 38.0
        zoom.duration = 0.4
        
        let fadeout = CABasicAnimation.init(keyPath: "opacity")
        fadeout.toValue = 0.0
        fadeout.duration = 0.4
        
        let group = CAAnimationGroup()
        group.duration = 0.4
        group.animations = [zoom, fadeout]
        group.fillMode = kCAFillModeForwards
        group.isRemovedOnCompletion = false
        clickLayer.add(group, forKey: "animationKey")
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapImage(recon:)))
        imgView.addGestureRecognizer(tap)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
