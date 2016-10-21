//
//  BetterRefreshHeader.swift
//  BetterRefresh
//
//  Created by Hony on 2016/10/18.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

/// 草你奶奶。 为什么这里写open 就 影响 required init?(coder aDecoder: NSCoder)

 class BetterRefreshHeader: UIView {
    
    typealias refreshHandel = () -> Void
    
    /// 刷新中的渐变 颜色
    private let ingColor =  UIColor.init(red: 234.0 / 255, green: 84.0 / 255, blue: 87.0 / 255, alpha: 0.3).cgColor
    
    private let springDamping: CGFloat = 0.4  /// spring 系数
    private let initialSpringVelocity: CGFloat = 0.8
    private let animationPacing = kCAMediaTimingFunctionEaseIn /// 动画参数
    private let kAnimationKey = "HeaderRefreshViewAnimationKey" ///光晕动画ID
    private let pHaloWidth = 2.5 ///  默认光晕宽度
    
    private var associatedScrollView: UIScrollView! /// scrollView
    
    private var refresAction: refreshHandel! /// 刷新的回调
    
    private var pullToRefreshHeight: CGFloat = 60 /// 触发刷新的最大高度
    
    private var animationLayer: CALayer? /// 动画图层
    
    private var pathLayer: CAShapeLayer? /// 笔画图层
    
    private var isFlash: Bool = true ///是否xianshi
    
    private var gradientLayer: CAGradientLayer? /// 光晕图层
    
    private var isStop: Bool = true /// 是否停止
    
    private var originOffsetY:  CGFloat = 0 /// 初始的距离。
    
    private var progress: CGFloat = 0{/// 比例
        didSet{
            let distance = associatedScrollView.contentOffset.y + originOffsetY
//            print("往下拉 比例为:\(progress) distance = \(distance)")
            self.center = CGPoint(x: self.center.x, y: -fabs(distance * 0.5))
            
            let diff = fabs( self.associatedScrollView.contentOffset.y + originOffsetY) - pullToRefreshHeight
            
            pathLayer?.strokeEnd = progress
            if diff > 0{ // 到达临界点了。
                if !associatedScrollView.isTracking { // returns YES if user has touched ,松手了
                    if !isStop {return} // 正在刷新。什么也不做。
                    if isFlash {
                        addRefreshAnimation()
                        UIView.animate(withDuration: 0.3, animations: {
                            self.associatedScrollView.contentInset = UIEdgeInsets(top: self.pullToRefreshHeight + self.originOffsetY, left: 0, bottom: 0, right: 0)
                        }) { (_) in
                            self.refresAction()
                        }
                        isFlash = false
                    }
                }
            }
        }
    }
    
    // MARK: INIT
    init(scrollView: UIScrollView, refreshHeight: CGFloat, refreshBlock: @escaping refreshHandel){
        
        super.init(frame:CGRect(x: 0, y: -refreshHeight, width: scrollView.bounds.width, height: refreshHeight))
        
        originOffsetY = 64
        self.associatedScrollView = scrollView
        self.pullToRefreshHeight = refreshHeight
        self.refresAction = refreshBlock
        
        // KVO监听
        self.associatedScrollView.addObserver(self, forKeyPath:#keyPath(UIScrollView.contentOffset) , options: .new, context: nil)
        
        animationLayer = CALayer()
        animationLayer?.frame = CGRect(x: 0, y: 0, width: scrollView.bounds.width, height: refreshHeight)
        layer.addSublayer(animationLayer!)
        addPullAnimation()
        isStop = true
        
    }
    
    
    
    /// KVO
    
    /// 开始刷新
    func beginRefreshing() {
        addRefreshAnimation()
        isStop = false
        
        UIView.animate(withDuration: 0.3, animations: {
            self.associatedScrollView.contentInset = UIEdgeInsets(top: self.pullToRefreshHeight + self.originOffsetY, left: 0, bottom: 0, right: 0)
        }) { (_) in
            self.refresAction()
            self.isStop = true
        }
    }
    
    
    /// 停止刷新
    func endRefreshing() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: springDamping, initialSpringVelocity: initialSpringVelocity, options: .curveLinear, animations: {
            self.alpha = 0.0
            self.associatedScrollView.contentInset = UIEdgeInsets(top: self.originOffsetY + 0.1, left: 0, bottom: 0, right: 0)
        }) { (_) in
            self.alpha = 1.0
            self.stopAnimating()
            self.addPullAnimation()
            self.pathLayer?.strokeEnd = 0.0
        }
        
    }

    
    /// 添加路径
    private func addAnimatePath(){
        if  let pathlay = self.pathLayer {
            pathlay.removeFromSuperlayer()
            pathLayer = nil
        }
        addPullAnimation()
    }
    
    private func addPullAnimation(){
        let pathlaye = CAShapeLayer.init(text: "C'est La Vie" , fontSize: 27)
        pathlaye?.position = CGPoint(x: (UIScreen.main.bounds.width - 140) * 0.5, y: -20)
        pathlaye?.anchorPoint = CGPoint(x: 0, y: 0)
        pathlaye?.bounds = (animationLayer?.bounds)!
        animationLayer?.addSublayer(pathlaye!)
        self.pathLayer = pathlaye
        isFlash = true
    }
    
    /// 添加刷新动画
    private func addRefreshAnimation() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = (animationLayer?.bounds)!
        gradientLayer.startPoint = CGPoint(x: 0, y: 5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        gradientLayer.colors = [ingColor,UIColor.white.cgColor, ingColor]
        
        gradientLayer.locations = [0.25, 0.5, 0.75]
        animationLayer?.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
        
        let pathL = CAShapeLayer.init(text: "La Vie est belle" , fontSize: 23)
        
        pathL!.position = CGPoint(x: (UIScreen.main.bounds.width - 130) * 0.5, y: -20)
        pathL!.anchorPoint = CGPoint(x: 0, y: 0)
        pathL!.bounds = (animationLayer?.bounds)!
        self.gradientLayer?.backgroundColor = UIColor.init(red: 232 / 255.0, green: 93 / 255.0, blue: 97 / 255.0, alpha: 0.6).cgColor
        self.gradientLayer?.addSublayer(pathL!)
        gradientLayer.mask = pathL
        if self.pathLayer != nil {
            self.pathLayer?.removeFromSuperlayer()
            self.pathLayer = nil
        }
        startAnimating()
    }
    
    /// 停止动画
    private func stopAnimating(){
        gradientLayer?.removeFromSuperlayer()
        gradientLayer = nil
    }
    
    /// 开始动画
    private func startAnimating() {

        let gradientStartPointKey = "startPoint"
        let gradientEndPointKey = "endPoint";
        
        if ((gradientLayer?.animation(forKey: kAnimationKey)) == nil) {
            
            let startPointAnimation = CABasicAnimation.init(keyPath: gradientStartPointKey)
            startPointAnimation.fromValue = NSValue.init(cgPoint: CGPoint(x: 0.0, y: 0))
            startPointAnimation.toValue = NSValue.init(cgPoint: CGPoint(x: 10.0, y: 0))
            startPointAnimation.timingFunction = CAMediaTimingFunction.init(name: animationPacing)
            
            let endPointAnimation = CABasicAnimation.init(keyPath: gradientEndPointKey)
            
            endPointAnimation.fromValue = NSValue.init(cgPoint: CGPoint(x: 0.0, y: 0))
            endPointAnimation.toValue = NSValue.init(cgPoint: CGPoint(x: pHaloWidth, y: 0))
            endPointAnimation.timingFunction = CAMediaTimingFunction.init(name: animationPacing)
            
            let group = CAAnimationGroup()
            group.duration = 1.2
            group.animations = [startPointAnimation , endPointAnimation]
            group.timingFunction = CAMediaTimingFunction.init(name: animationPacing)
            group.repeatCount = HUGE
            gradientLayer?.add(group, forKey: kAnimationKey)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        associatedScrollView.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset))
    }
    
    // MARK: - KVO 监听方法
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath! == "contentOffset" {
            guard let changeValue  = change else {return}
            guard let point = changeValue[.newKey] else{ return }
            let offsetY = (point as! NSValue).cgPointValue.y
            let detla = offsetY + originOffsetY
            if detla <= 0 { // 往下拉. 
                self.progress = max(0.0,min(fabs(detla/pullToRefreshHeight), 1.0))
            }
        }
    }
}
