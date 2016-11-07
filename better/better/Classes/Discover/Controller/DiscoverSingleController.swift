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
        view.backgroundColor = UIColor.white
        view.addSubview(topCollectionView)
        topCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10 + 64)
            make.left.equalToSuperview().offset(5) // 10
            make.right.equalToSuperview().offset(-5) // -10
            make.height.equalTo(290)
        }
    }
}


typealias CollectionProtocol = DiscoverSingleController

extension CollectionProtocol: UICollectionViewDelegate , UICollectionViewDataSource{
    
    
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
}
