//
//  PHAsset+extension.swift
//  better
//
//  Created by Hony on 2016/11/28.
//  Copyright © 2016年 Hony. All rights reserved.
//

import Foundation
import Photos

extension PHAsset{
    /// 根据自己的宽高比 获取适应的图片
    typealias back = (_ img: UIImage?, _ info: [AnyHashable : Any]?) -> Void
    
    func fitImage(callBack: @escaping back) {
        let tgSize = self.fitSize()
        let opt = PHImageRequestOptions()
        opt.isSynchronous = true
        opt.deliveryMode = .highQualityFormat
        PHImageManager.default().requestImage(for: self, targetSize: tgSize, contentMode: .default, options: opt, resultHandler: {
            img, info in
            
            callBack(img?.resizeTo(size: tgSize), info)
        })
    }
    
    
     func fitSize() -> CGSize {
        let fixW = UIConst.screenWidth
        let fixH = UIConst.screenHeight - 210.0 - 80.0
        // 宽高比
        let scale = CGFloat(self.pixelWidth) / CGFloat(self.pixelHeight)
        let tgSize: CGSize
        
        if scale > 1{ //宽度长。定高。
            tgSize = CGSize(width: fixH * scale, height: fixH)
        }else{ // 高度长。则定宽
            tgSize = CGSize(width: fixW, height: fixW / scale)
        }
        return tgSize
    }
}
