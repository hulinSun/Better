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
    
    let filters: [BasicOperation] = [ZoomBlur(),MotionBlur(),MonochromeFilter(),SepiaToneFilter(),ThresholdSketchFilter(),EmbossFilter(),ZoomBlur(),ZoomBlur(),ZoomBlur()]
    
    var img: UIImage!{
        didSet{
            var v = [FiltItem]()
            for i in 0..<8 {
              let i = FiltItem(img: img, filter:filters[i])
                v.append(i)
            }
            datas = v
        }
    }
    
    var datas: [FiltItem]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    @IBAction func leftBtnClick(_ sender: Any) {
        
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
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoFilterCell", for: indexPath) as! PhotoFilterCell
        cell.item = datas?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
}
