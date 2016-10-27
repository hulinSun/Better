//
//  PictureProtocol.swift
//  Wireless
//
//  Created by Hony on 2016/10/27.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

/**************** PageControlAlimentProtocol ***********************/
enum PageControlAliment {
    case center
    case left
    case right
}

protocol PageControlAlimentProtocol: class {
    var pageControlAliment: PageControlAliment {get set}
    func adjustPageControlPlace(pageControl: UIPageControl)
}

//在这个扩展内声明的方法只有UIView才能看到
extension PageControlAlimentProtocol where Self : UIView {
    func adjustPageControlPlace(pageControl: UIPageControl) {
        
        if !pageControl.isHidden {
            switch self.pageControlAliment {
            case .center:
                let pageW:CGFloat = CGFloat(pageControl.numberOfPages * 15)
                let pageH:CGFloat = 20
                let pageX = self.center.x - 0.5 * pageW
                let pageY = self.bounds.height -  pageH
                pageControl.frame = CGRect(x: pageX, y: pageY, width: pageW, height: pageH)
                
            case .left:
                let pageW:CGFloat = CGFloat(pageControl.numberOfPages * 15)
                let pageH:CGFloat = 20
                let pageX = self.bounds.origin.x
                let pageY = self.bounds.height -  pageH
                pageControl.frame = CGRect(x: pageX, y: pageY, width: pageW, height: pageH)
                
            case .right:
                let pageW:CGFloat = CGFloat(pageControl.numberOfPages * 15)
                let pageH:CGFloat = 20
                let pageX = self.bounds.width - pageW
                let pageY = self.bounds.height -  pageH
                pageControl.frame = CGRect(x: pageX, y: pageY, width: pageW, height: pageH)
                
            }
        }
    }
}


/**************** WirelessPictureProtocol ***********************/


protocol WirelessPictureProtocol: class{
    
    /// 是否开启自动滚动
    var autoScroll: Bool {get set}
    
    /// 开启自动滚动后，自动翻页的时间
    var timeInterval: Double {get set}
    
    /// 用于控制自动滚动的定时器
    var timer: Timer? {get set}
    
    /// 是否开启无限滚动模式
    var needEndlessScroll: Bool {get set}
    
    /// 开启无限滚动模式后，cell需要增加的倍数
    var imageTimes: Int {get}
    
    /// 开启无限滚动模式后,真实的cell数量
    var actualItemCount: Int {get set}
    
    /// 设置定时器,用于控制自动翻页
    func beginTimer()
    
    
    /// 在无限滚动模式中，显示的第一页其实是最中间的那一个cell
    func showFirstImagePageInCollectionView(collectionView: UICollectionView)
}


extension WirelessPictureProtocol where Self : UIView  {
    
    func autoChangePicture(collectionView: UICollectionView) {
        guard actualItemCount != 0 else { return }
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        print(collectionView.contentOffset.x )
        let currentIndex = Int(collectionView.contentOffset.x / flowLayout.itemSize.width)
        
        print(currentIndex)
        
        let nextIndex = currentIndex + 1
        if nextIndex >= actualItemCount {
            showFirstImagePageInCollectionView(collectionView: collectionView)
        }else {
            collectionView.scrollToItem(at: IndexPath.init(item: nextIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
        
    }
    
    func showFirstImagePageInCollectionView(collectionView: UICollectionView) {
        guard actualItemCount != 0 else {
            return
        }
        var newIndex = 0
        if needEndlessScroll {
            newIndex = actualItemCount / 2
        }
        collectionView.scrollToItem(at: IndexPath.init(item: newIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
}
