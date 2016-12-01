//
//  FilterTool.swift
//  better
//
//  Created by Hony on 2016/11/30.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import  GPUImage

/// 滤镜帮助类
class FilterTool: NSObject {
    
    static let list: [String: AnyObject] = [
        "复古": SoftElegance(),
        "HDR": MissEtikateFilter(),
        "优格": AmatorkaFilter(),
        "卡通": SmoothToonFilter(),
        "素描": SketchFilter(),
        "Box": BoxBlur(),
        "水粉画": KuwaharaFilter(),
        "浮雕": EmbossFilter(),
        "朦胧": Haze(),
        "Threshold": ThresholdSketchFilter(),
        "晕影": Vignette(),
        "水晶球": GlassSphereRefraction()
    ]
    static let types: [String] = ["复古","HDR","优格","卡通","素描","Box","水粉画","浮雕","朦胧","Threshold","晕影","水晶球"]
    
    static var arr = [UIImage]()
    
    static var small = [UIImage]()
    
    class func allFilterd(with image: UIImage) -> [UIImage] {
        if arr.isEmpty {
            
            arr.append(self.softElegance(with: image,big: true))
            arr.append(self.missEtikate(with: image,big: true))
            arr.append(self.amatorka(with: image,big: true))
            arr.append(self.smoothToon(with: image,big: true))
            arr.append(self.sketch(with: image,big: true))
            arr.append(self.boxBlur(with: image,big: true))
            arr.append(self.kuwahara(with: image,big: true))
            arr.append(self.emboss(with: image,big: true))
            arr.append(self.haze(with: image,big: true))
            arr.append(self.thresholdSketch(with: image,big: true))
            arr.append(self.vignette(with: image,big: true))
            arr.append(self.glassSphereRefraction(with: image,big: true))
        }
        return arr
    }
    
    
    class func smallFilterd(with image: UIImage) -> [UIImage] {
        if small.isEmpty{
            small.append(self.softElegance(with: image,big: false))
            small.append(self.missEtikate(with: image,big: false))
            small.append(self.amatorka(with: image,big: false))
            small.append(self.smoothToon(with: image,big: false))
            small.append(self.sketch(with: image,big: false))
            small.append(self.boxBlur(with: image,big: false))
            small.append(self.kuwahara(with: image,big: false))
            small.append(self.emboss(with: image,big: false))
            small.append(self.haze(with: image,big: false))
            small.append(self.thresholdSketch(with: image,big: false))
            small.append(self.vignette(with: image,big: false))
            small.append(self.glassSphereRefraction(with: image,big: false))
        }
        return small
    }
    
    /// 某个索引
    class func filterdImage(at index: Int, img: UIImage) -> UIImage {
        let new = img.resizeTo(size: CGSize(width: UIConst.screenWidth, height: UIConst.screenHeight - 290))
        if arr.isEmpty {
            arr = self.allFilterd(with: new)
            return arr[index]
        }else{
            return arr[index]
        }
    }
    
    
    /// 复古
    class func softElegance(with image: UIImage, big: Bool ) -> UIImage {
        let new = self.realImage(with: image, big: big)
        let toonFilter = SoftElegance()
        let filteredImage = new.filterWithOperation(toonFilter)
        return filteredImage
    }
    
    /// HDR
    class func missEtikate(with image: UIImage , big: Bool ) -> UIImage {
        let new = self.realImage(with: image, big: big)
        let toonFilter = MissEtikateFilter()
        let filteredImage = new.filterWithOperation(toonFilter)
        return filteredImage
    }
    /// 优格
    class func amatorka(with image: UIImage, big: Bool ) -> UIImage {
        let new = self.realImage(with: image, big: big)
        let toonFilter = AmatorkaFilter()
        let filteredImage = new.filterWithOperation(toonFilter)
        return filteredImage
    }
    /// 卡通
    class func smoothToon(with image: UIImage, big: Bool ) -> UIImage {
        let new = self.realImage(with: image, big: big)
        let toonFilter = SmoothToonFilter()
        let filteredImage = new.filterWithOperation(toonFilter)
        return filteredImage
    }
    /// 素描
    class func sketch(with image: UIImage, big: Bool ) -> UIImage {
        let new = self.realImage(with: image, big: big)
        let toonFilter = SketchFilter()
        let filteredImage = new.filterWithOperation(toonFilter)
        return filteredImage
    }
    /// 亮白
    class func boxBlur(with image: UIImage, big: Bool ) -> UIImage {
        let new = self.realImage(with: image, big: big)
        let toonFilter = BoxBlur()
        let filteredImage = new.filterWithOperation(toonFilter)
        return filteredImage
    }
    
    /// 水粉画
    class func kuwahara(with image: UIImage, big: Bool ) -> UIImage {
        let new = self.realImage(with: image, big: big)
        let toonFilter = KuwaharaFilter()
        let filteredImage = new.filterWithOperation(toonFilter)
        return filteredImage
    }
    
    /// 浮雕
    class func emboss(with image: UIImage, big: Bool ) -> UIImage {
        let new = self.realImage(with: image, big: big)
        let toonFilter = EmbossFilter()
        let filteredImage = new.filterWithOperation(toonFilter)
        return filteredImage
    }
    
    /// 朦胧
    class func haze(with image: UIImage, big: Bool ) -> UIImage {
        let new = self.realImage(with: image, big: big)
        let toonFilter = Haze()
        let filteredImage = new.filterWithOperation(toonFilter)
        return filteredImage
    }
    
    
    //FIXME: XX
    /// 桑园
    class func thresholdSketch(with image: UIImage, big: Bool ) -> UIImage {
        let new = self.realImage(with: image, big: big)
        let toonFilter = ThresholdSketchFilter()
        let filteredImage = new.filterWithOperation(toonFilter)
        return filteredImage
    }
    
    /// 晕影
    class func vignette(with image: UIImage, big: Bool ) -> UIImage {
        let new = self.realImage(with: image, big: big)
        let toonFilter = Vignette()
        let filteredImage = new.filterWithOperation(toonFilter)
        return filteredImage
    }
    
    /// 水晶球
    class func glassSphereRefraction(with image: UIImage, big: Bool ) -> UIImage {
        let new = self.realImage(with: image, big: big)
        let toonFilter = GlassSphereRefraction()
        let filteredImage = new.filterWithOperation(toonFilter)
        return filteredImage
    }
    
    
    private class func realImage(with image: UIImage, big: Bool ) -> UIImage {
        var size: CGSize = .zero
        if big == true{
            size = CGSize(width: UIConst.screenWidth, height: UIConst.screenHeight - 290)
        }else{
            size = CGSize(width: 100, height: 100)
        }
        return image.resizeTo(size: size)
    }
    
    
}
