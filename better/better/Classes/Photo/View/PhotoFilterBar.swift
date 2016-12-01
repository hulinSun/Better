//
//  PhotoFilterBar.swift
//  better
//
//  Created by Hony on 2016/11/30.
//  Copyright © 2016年 Hony. All rights reserved.
//
import GPUImage
import UIKit

class PhotoFilterBar: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterBtn: PhotoItemButton!
    typealias leftClosure = ()-> Void
    
    typealias clickItemClosure = (_ index: IndexPath) -> Void
    
    var leftClickClo: leftClosure?
    var clickItemClo: clickItemClosure?
    var img: UIImage!{
        didSet{
            let arr = FilterTool.smallFilterd(with: img)
            let types = FilterTool.types
            var temp = [FiltItem]()
            for i in 0..<arr.count{
                let t = FiltItem(img: arr[i], name: types[i])
                temp.append(t)
            }
            datas = temp
        }
    }
    
    var datas: [FiltItem]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    @IBAction func leftBtnClick(_ sender: Any) {
        leftClickClo?()
    }

    @IBAction func nextClick(_ sender: Any) {
        
    }
    
    @IBAction func barClick(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
    }
    
    
    
    private func setupUI(){
        collectionView.register(UINib.init(nibName: "PhotoFilterCell", bundle: nil), forCellWithReuseIdentifier:"PhotoFilterCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
}


extension PhotoFilterBar: UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickItemClo?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoFilterCell", for: indexPath) as! PhotoFilterCell
        cell.item = datas?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas?.count ?? 0
    }
    
}
