//
//  WirelessPictureView.swift
//  Wireless
//
//  Created by Hony on 2016/10/27.
//  Copyright © 2016年 Hony. All rights reserved.
//
import UIKit


/// 无限滚动的view
class WirelessPictureView: UIView , PageControlAlimentProtocol , WirelessPictureProtocol{
    
    //MARK: - 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, localImageArray: [String]) {
        super.init(frame: frame)
        self.imageInfo = ImageInfo.init(type: .local, imageArray: localImageArray)
        self.localImageArray = localImageArray
        setupUI()
        reloadData()
        
    }
    
    init(frame: CGRect, networkImageArray: [String]) {
        super.init(frame: frame)
        self.netWorkImageArray = networkImageArray
        self.imageInfo = ImageInfo.init(type: .newWork, imageArray: networkImageArray)
        setupUI()
        reloadData()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pictureLayout.itemSize = CGSize(width: self.bounds.width, height: self.bounds.height)
        collectionView.frame = self.bounds
        
        adjustPageControlPlace(pageControl: pageControl)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if let _ = newSuperview {
            stopTimer()
        }
    }
    
    // MARK: - 懒加载
    fileprivate lazy var pageControl: UIPageControl = {
        let i = UIPageControl()
        i.hidesForSinglePage = true
        i.isUserInteractionEnabled = false
        i.pageIndicatorTintColor = self.pageIndicatorTintColor
        i.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor
        return i
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        
        let i = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: self.pictureLayout)
        i.register(PictureCell.self, forCellWithReuseIdentifier: "PictureCell")
        i.contentInset = .zero
        i.collectionViewLayout = self.pictureLayout
        i.isPagingEnabled = true
        i.showsVerticalScrollIndicator = false
        i.showsHorizontalScrollIndicator = false
        i.bounces = false
        return i
    }()
    
    fileprivate lazy var pictureLayout: UICollectionViewFlowLayout = {
        let i = UICollectionViewFlowLayout()
        i.scrollDirection = .horizontal
        i.minimumLineSpacing = 0
        
        return i
    }()
    
    // MARK: -  公有属性
    /// 本地图片
    var localImageArray: [String]?{
        didSet{
           self.imageInfo = ImageInfo.init(type: .local, imageArray: localImageArray!)
            reloadData()
        }
    }
    
    /// 网络图片
    var netWorkImageArray: [String]?{
        didSet{
           self.imageInfo = ImageInfo(type: .newWork, imageArray: netWorkImageArray!)
            reloadData()
        }
    }
    
    
    var showPageControl: Bool = true {
        didSet {
            self.pageControl.isHidden = !showPageControl
        }
    }
    
    var currentPageIndicatorTintColor: UIColor = UIColor.orange {
        didSet {
            self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        }
    }
    
    var pageIndicatorTintColor: UIColor = UIColor.gray {
        didSet {
            self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor
        }
    }
    
    /// 是否自动滚动
    var autoScroll: Bool = true {
        didSet {
            if autoScroll {
                beginTimer()
            }
        }
    }
    /// 开启自动滚动后，自动翻页的时间，默认为2秒
    var timeInterval: Double = 2.0 {
        didSet {
            if autoScroll {
                beginTimer()
            }
        }
    }
    
    /// 是否是无线滚动。 默认是无线滚动
    var needEndlessScroll: Bool  = true {
        didSet {
            reloadData()
        }
    }
    
    
    /// pageControl的位置，默认是剧中在底部(PageControlAlimentProtocol提供)
    var pageControlAliment: PageControlAliment = .center
    
    /// 开启无限滚动模式后,真实的cell数量
    var actualItemCount: Int = 0 // Protocol提供
    let imageTimes: Int = 50   // Protocol提供的不能写private
    internal var timer: Timer?
    
    /// 加载网络图片使用的占位图片
    var placeholderImage: UIImage?
    /// 图片的对齐模式
    var pictureContentMode: UIViewContentMode?

    
    // MARK: - 私有属性
    fileprivate var imageInfo: ImageInfo!
    
    // MARK: - 私有方法
    private func setupUI() {
        addSubview(collectionView)
        addSubview(pageControl)
        collectionView.delegate = self
        collectionView.dataSource = self
        if imageInfo.imageArray.isEmpty {
            pageControl.isHidden = true
        }
        pageControl.numberOfPages = self.imageInfo.imageArray.count
    }
    
    
    
    /// 刷新
    private func reloadData(){
        
        if imageInfo.imageArray.count > 1 {
            self.actualItemCount =  self.needEndlessScroll ? imageInfo.imageArray.count * imageTimes : imageInfo.imageArray.count
            pageControl.numberOfPages = imageInfo.imageArray.count
        }else {
            self.actualItemCount = 1
        }
        
        self.collectionView.reloadData()
        
        if self.autoScroll { beginTimer() }

    }
    
    /// 开启定时器
     func beginTimer(){
        stopTimer()
        let t = Timer.scheduledTimer(withTimeInterval: self.timeInterval, repeats: true, block: {  (timer) in
            self.autoChangePicture(collectionView: self.collectionView)
        })
        RunLoop.main.add(t, forMode: .commonModes)
        self.timer = t
    }
    
    
    /// 停止定时器
     func stopTimer(){
        self.timer?.invalidate()
        self.timer = nil
    }
}




typealias CollectionViewProtocol = WirelessPictureView

extension CollectionViewProtocol: UICollectionViewDelegate , UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageInfo.imageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as! PictureCell
        cell.imageSource = self.imageInfo.imageArray[indexPath.item]
        cell.placeHolderImage = self.placeholderImage
        cell.pictureContentMode = self.pictureContentMode ?? .scaleAspectFill
        return cell
    }
}


extension WirelessPictureView: UIScrollViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if self.autoScroll {
            stopTimer()
        }
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.autoScroll {
            beginTimer()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetIndex = self.collectionView.contentOffset.x / self.pictureLayout.itemSize.width
        
        let currentIndex = Int((offsetIndex.truncatingRemainder(dividingBy: CGFloat(self.imageInfo.imageArray.count))) + 0.5)
        
//        let currentIndex = Int(offsetIndex / CGFloat(self.imageInfo!.imageArray.count) + 0.5)
        
        pageControl.currentPage = currentIndex == self.imageInfo!.imageArray.count ? 0 :currentIndex
    }
}

