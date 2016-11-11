//
//  PhotoViewController.swift
//  better
//
//  Created by Hony on 2016/10/14.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import Photos

struct GridModel {
    
    var isCamera: Bool = false
    var indexPath: IndexPath
    var isSelected: Bool = false
    var image: UIImage
}

class PhotoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getCollection()
    }
    
    var choosedCell: PhotoGridCell?
    
    fileprivate lazy var mutiChoosedIndex: [IndexPath] = {
        let i = [IndexPath]()
        return i
    }()
    
    
    fileprivate lazy var collectionView: UICollectionView = {
        let i = UICollectionView(frame: .zero, collectionViewLayout: self.photoLayout)
        i.showsVerticalScrollIndicator = false
        i.showsHorizontalScrollIndicator = false
        i.delegate = self
        i.dataSource = self
        i.contentInset = UIEdgeInsets(top: 7.5, left: 2.5, bottom: 0, right: 2.5)
        i.register(PhotoGridCell.self, forCellWithReuseIdentifier: "PhotoGridCell")
        i.backgroundColor = .white
        return i
    }()
    
    fileprivate lazy var images: [UIImage] = {
        let i = [UIImage]()
        return i
    }()
    
    static let tgSize: CGSize = CGSize(width: ((UIConst.screenWidth - 5) / 3.0) * (UIConst.screenScale), height: ((UIConst.screenWidth - 5 ) / 3.0) * (UIConst.screenScale))
    
    fileprivate lazy var photoLayout: UICollectionViewFlowLayout = {
        let i = UICollectionViewFlowLayout()
        i.itemSize = CGSize(width: (UIConst.screenWidth - 5) / 3.0, height: (UIConst.screenWidth - 5) / 3.0)
        i.minimumInteritemSpacing = 0
        i.minimumLineSpacing = 0
        return i
    }()
    
    func hony()  {
        dismiss(animated: true)
    }
    
    func setupUI()  {
        
        if let hair = UINavigationBar.getLine(view:(navigationController?.navigationBar)!){ hair.isHidden = true }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Hony", style: .plain, target: self, action: #selector(hony))
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    func getCollection() {
        // 判断授权状态
        PHPhotoLibrary.requestAuthorization { (status) in
            if status != .authorized{
                print("用户没有授权。想办法搞一搞事情")
                return
            }
            
            // 能来到这里肯定已经授权了
            DispatchQueue.main.async { // 开启子线程来获取
                print("x = \(Thread.current)")
                // album 自定义的相册如微博 QQ等
                let albumCollections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
                
                albumCollections.enumerateObjects({ (collection, _, _) in
//                    print("ablum = \(collection.localizedTitle)")
                    self.getImages(collection: collection)
                })
                
                // smartAlbum 系统自带的相册。最近删除，最近添加等
                let smartAlbumCollection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
                
                smartAlbumCollection.enumerateObjects({ (collection, _, _) in
//                    print("smartAlbum = \(collection.localizedTitle)")
                    self.getImages(collection: collection)
                })
                print("albumCollections = \(albumCollections.count) ,smartAlbumCollection = \(smartAlbumCollection.count)")
            }
        }
    }

    
    func getImages(collection: PHAssetCollection) {
        
        // 图片
        let result = PHAsset.fetchAssets(in: collection, options: nil)
        
        // 自定义的相册即使没有图片 也要、 系统的相册没有图片就剔除掉
//        if collection.assetCollectionType == .album{
//            print("自定义 =\(collection.localizedTitle)")
//        }

        print(collection.localizedTitle)
        if collection.localizedTitle == "Camera Roll"{
            let opt = PHImageRequestOptions()
            opt.deliveryMode = .highQualityFormat
            
            if result.count > 0{
                print("title = \(collection.localizedTitle) , count = \(result.count)")
                
                result.enumerateObjects ({ (asset, idx, stop) in
                    // 获取图片
                    PHImageManager.default().requestImage(for: asset, targetSize:PhotoViewController.tgSize, contentMode: .default, options: opt, resultHandler: { (img, dict) in
                        if let i = img{
                            self.images.append(i)
                        }
                    })
                })
            }
            
            DispatchQueue.main.after(delay: 3, execute: {
                // 刷新
                self.collectionView.reloadData()
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true)
    }


    
    func other() {
        
        /**
         let group = DispatchGroup()
         let queue = DispatchQueue(label: "myBackgroundQueue")
         queue.async(group:group) {
         print("background working")
         }
         */
//            let group = DispatchGroup()
//            group.enter()
//            group.leave()
//            group.notify(queue: DispatchQueue.main, execute: {
//
//            })
        let collects =  PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
        /// 这里为什么不能用尾闭包的写法/。否则会报错
        collects.enumerateObjects ({ (collection, start, stop) in
            // 相册--> 图片
            let imageColls = PHAsset.fetchAssets(in: collection, options: nil)
            imageColls.enumerateObjects({ (asset, start, stop) in
                print(asset)
                PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil, resultHandler: { (image, dict) in
                    print("image = \(image) ")
                })
            })
        })
    }
}




typealias PhotoViewCollectionProtocol = PhotoViewController

extension PhotoViewCollectionProtocol: UICollectionViewDelegate , UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count > 0 ? images.count + 1 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGridCell", for: indexPath) as! PhotoGridCell
        if indexPath.item == 0{
            cell.isCamera = true
        }else{
            cell.img = images[indexPath.item - 1]
            cell.isCamera = false
        }
        
        cell.indexPath = indexPath
        cell.clickClosure = { (cell , idx) in
            // 在这里做单选 还是 多选的 操作
            if true { // 默认单选s
                cell.isChoosed = true
                self.choosedCell?.isChoosed = false
                self.choosedCell = cell
            }else{ // 多选
                let res = self.checkInChoosed(indexPath: idx)
                if(self.mutiChoosedIndex.count > 2) && (res.0 == false){ // 点的不是之前选的
                    print("最多选三张")
                    return
                }
                cell.isChoosed = !cell.isChoosed
                if res.0 == true{ // 在数组中
                    self.mutiChoosedIndex.remove(at: res.1)
                }else{
                    self.mutiChoosedIndex.append(idx)
                }
                print(self.mutiChoosedIndex)
            }
        }
        return cell
    }
    
    /// 判断传过来的idx 是否在数组中
    private func checkInChoosed(indexPath: IndexPath)-> (Bool,Int){
        var res = (false,0)
        for (idx, item) in mutiChoosedIndex.enumerated(){
            if indexPath.item == item.item {
                res = (true, idx)
            }
        }
        return res
    }
}
