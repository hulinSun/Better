//
//  PhotoViewController.swift
//  better
//
//  Created by Hony on 2016/10/14.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import Photos

class PhotoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        getCollection()
        
    }
    
    func getCollection() {
        
        let opt = PHImageRequestOptions()
        opt.isSynchronous = true
        let collects =  PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
        /// 这里为什么不能用尾闭包的写法/。否则会报错
        collects.enumerateObjects ({ (collection, start, stop) in
            // 相册--> 图片
            let imageColls = PHAsset.fetchAssets(in: collection, options: nil)
            imageColls.enumerateObjects({ (asset, start, stop) in
                print(asset)
                
                PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil, resultHandler: { (image, dict) in
                    print(image)
                })
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true)
    }


}
