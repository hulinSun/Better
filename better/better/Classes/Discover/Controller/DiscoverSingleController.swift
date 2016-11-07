//
//  DiscoverSingleController.swift
//  better
//
//  Created by Hony on 2016/11/7.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit


/// 发现页 单品控制器
class DiscoverSingleController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        DiscoverHttpHelper.requestDiscoverSingleCategory { (category) in
            self.topDatas = category
        }
        
        DiscoverHttpHelper.requestDiscoverHot { (hot) in
        }
    }

    
    var topDatas: SingleProCategory?{
        didSet{
            let count = Int((topDatas?.data?.category_list?.count)! / 6) + 1
            pageControl.numberOfPages = count
            topCollectionView.reloadData()
        }
    }
    
    fileprivate lazy var topCollectionView: UICollectionView = {
        let i = UICollectionView(frame: .zero, collectionViewLayout: self.topLayout)
        i.register(UINib(nibName: "TopCategoryCell", bundle: nil), forCellWithReuseIdentifier: "TopCategoryCell")
        i.backgroundColor = UIColor.white
        i.showsVerticalScrollIndicator = false
        i.showsHorizontalScrollIndicator = false
        i.delegate = self
        i.dataSource = self
        i.isPagingEnabled = true
        return i
    }()
    
    
    fileprivate lazy var pageControl: UIPageControl = {
        let i = UIPageControl()
        i.hidesForSinglePage = true
        i.pageIndicatorTintColor = UIColor.init(hexString: "#e4e4e4")
        i.currentPageIndicatorTintColor = UIColor.init(hexString: "#fd6363")
        return i
    }()
    
    fileprivate lazy var topView: UIView = {
        let i = UIView()
        
        // 按钮
        let btn = UIButton()
        btn.backgroundColor = UIColor.clear
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitle("分类", for: .normal)
        btn.setImage(UIImage(named:"descover_categoty_icon"), for: .normal)
        btn.imageView?.contentMode = .center
        btn.setTitleColor(UIColor.init(hexString: "#999999"), for: .normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        i.addSubview(btn)
        i.addSubview(self.topCollectionView)
        i.addSubview(self.pageControl)
        
        // 约束
        btn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
        self.topCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(290)
        }
        
        self.pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.bottom.equalToSuperview()
            make.height.equalTo(30)
        }
        return i
    }()
    
    fileprivate lazy var topLayout: UICollectionViewFlowLayout = {
        let i = UICollectionViewFlowLayout()
        i.itemSize = CGSize(width: (UIConst.screenWidth - 10) * CGFloat(0.5), height: 90)
        i.scrollDirection = .horizontal
        i.minimumLineSpacing = 0
        i.minimumInteritemSpacing = 0
        return i
    }()
    
    
    fileprivate lazy var bottomCollectionView: UICollectionView = {
        let i = UICollectionView(frame: .zero, collectionViewLayout: self.bottomLayout)
        return i
    }()
    fileprivate lazy var bottomLayout: UICollectionViewFlowLayout = {
        let i = UICollectionViewFlowLayout()
        return i
    }()
    
    fileprivate func setupUI(){
        
        view.backgroundColor = UIColor.init(hexString: "f4f4f4")
        view.addSubview(topView)
        topView.backgroundColor = UIColor.white
        topView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10 + 64)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(360)
        }
    }
}


typealias CollectionProtocol = DiscoverSingleController

extension CollectionProtocol: UICollectionViewDelegate , UICollectionViewDataSource , UIScrollViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topDatas?.data?.category_list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCategoryCell", for: indexPath) as! TopCategoryCell
        cell.item = topDatas?.data?.category_list?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let item = topDatas?.data?.category_list?[indexPath.item] else { return }
        print("点击了\(item.name)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
    }
    
}
