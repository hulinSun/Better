//
//  PictureCell.swift
//  Wireless
//
//  Created by Hony on 2016/10/27.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import Kingfisher


enum ImageSource {
    case local(name: String) // 本地
    case network(urlStr: String) // 网络获取
}

enum imageType {
    case local
    case newWork
}


//MARK: - 图片的信息。包含是本地还是远程的信息
struct ImageInfo {
    
    var imageArray: [ImageSource]
    var imageType: imageType
    
    init(type: imageType, imageArray:[String]) {
        
//        assert(imageArray.isEmpty , "imageArray cannot nil")
        self.imageType = type
        var array = [ImageSource]()
        switch type {
        case .local:
            imageArray.forEach {array.append(ImageSource.local(name: $0))}
        case .newWork:
            imageArray.forEach {array.append(ImageSource.network(urlStr: $0))}
        }
        self.imageArray = array
    }
    
    subscript (index: Int) -> ImageSource {
        get {
            return self.imageArray[index]
        }
    }
}

class PictureCell: UICollectionViewCell {
    
    // MARK: - 懒加载
    private lazy var pictureView: UIImageView = {
        let i = UIImageView()
        i.clipsToBounds = true
        i.contentMode = self.pictureContentMode
        i.backgroundColor = UIColor.white
        return i
    }()
    
    // MARK: - 属性
    var imageSource: ImageSource = ImageSource.local(name: ""){
        didSet {
            switch imageSource {
            case let .local(name):
                self.pictureView.image = UIImage(named: name)
            case let .network(urlStr):
                if let encodeString = urlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed){
                    
                    self.pictureView.kf.setImage(with: URL(string: encodeString), placeholder: placeHolderImage)
                }
            }
        }
    }
    
    /// 站位图片
    var placeHolderImage: UIImage?
    
    var pictureContentMode: UIViewContentMode = .scaleAspectFill {
        didSet {
            pictureView.contentMode = pictureContentMode
        }
    }
    
    // MARK: - 系统方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pictureView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
    }
    
    
    //MARK: - 私有方法
    private func setupUI() {
        contentView.addSubview(pictureView)
        self.backgroundColor = UIColor.white
    }
}
