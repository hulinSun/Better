//
//  PhotoViewController.swift
//  better
//
//  Created by Hony on 2016/10/14.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import Photos

class PhotoGroupItem: CustomStringConvertible {
    var count: Int /// 个数
    var firstImg: PHAsset? /// 第一张图片
    var result: PHFetchResult<PHAsset>? /// 这一组的所有图片
    var name: String /// 相册名
    
    var description: String{
        return "name is \(self.name) count = \(self.count)  firstimg =\(self.firstImg) "
    }
    
    init(count: Int, firstImg: PHAsset?, result: PHFetchResult<PHAsset>?, name: String) {
        self.count = count
        self.firstImg = firstImg
        self.result = result
        self.name = name
    }
}


class GridItem {
    
    var choosed: Bool = false
    var asset: PHAsset?
    var isCarmea: Bool = false
    
    init(choosed: Bool, asset: PHAsset?, isCarmea: Bool) {
        self.choosed = choosed
        self.asset = asset
        self.isCarmea = isCarmea
    }
}



class PhotoViewController: UIViewController {
    
    var gridItems:[GridItem] = [GridItem](){
        didSet{
            collectionView.reloadData()
        }
    }
    

    fileprivate lazy var photoCollections: [PHFetchResult<PHAssetCollection>] = {
    let i = [PHFetchResult<PHAssetCollection>]()
        return i
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getCollection()
    }
    
    /// tableview 的数据源
    fileprivate lazy var tableViewDatas: [PhotoGroupItem] = {
        let i = [PhotoGroupItem]()
        return i
    }()
    
    var choosedCell: PhotoGridCell?
    
    fileprivate lazy var mutiChoosedIndex: [IndexPath] = {
        let i = [IndexPath]()
        return i
    }()
    
    fileprivate lazy var tableView: GroupTableView = {
        let i = GroupTableView.init(frame: .zero, style: .plain)
        return i
    }()
    
    fileprivate lazy var navView: UIView = {
        let i = UIView()
        i.backgroundColor = UIColor.rgb(red: 242, green: 75, blue: 78)
        return i
    }()
    
    fileprivate lazy var titleView: PhotoTitleView = {
        let i = PhotoTitleView()
        i.setTitle("哈哈信息", for: .normal)
        i.addTarget(self, action: #selector(titleClick), for: .touchUpInside)
        return i
    }()

    fileprivate lazy var rightBtn: UIButton = {
        let i = UIButton()
        i.setTitle("确定", for: .normal)
        i.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        i.setTitleColor(.white, for: .normal)
        i.addTarget(self, action: #selector(right), for: .touchUpInside)
        return i
    }()
    
    fileprivate lazy var listView: UIView = {
        let i = UIView()
        i.backgroundColor = UIColor.lightGray
        i.isHidden = true
        return i
    }()
    
    fileprivate lazy var leftBtn: UIButton = {
        let i = UIButton()
        i.setTitle("取消", for: .normal)
        i.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        i.setTitleColor(.white, for: .normal)
        i.addTarget(self, action: #selector(left), for: .touchUpInside)
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
    
    fileprivate lazy var photoLayout: UICollectionViewFlowLayout = {
        let i = UICollectionViewFlowLayout()
        i.itemSize = CGSize(width: (UIConst.screenWidth - 5) / 3.0, height: (UIConst.screenWidth - 5) / 3.0)
        i.minimumInteritemSpacing = 0
        i.minimumLineSpacing = 0
        return i
    }()
    
    /// 点击按钮
    func titleClick(){
        view.addSubview(listView)
        view.bringSubview(toFront: navView)
        listView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
            make.bottom.equalTo(view.snp.top)
        }
        
        titleView.isEnabled = false
        titleView.isSelected = !titleView.isSelected
        listView.isHidden = false
        
        if titleView.isSelected {
            UIView.animate(withDuration: 0.25, animations: {
                self.listView.transform = CGAffineTransform.init(translationX: 0, y: 364)
            })
        }else{
            UIView.animate(withDuration: 0.25, animations: {
                self.listView.transform = CGAffineTransform.identity
            }) { (com) in
                self.listView.isHidden = true
            }
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.titleView.imageView?.transform = (self.titleView.imageView?.transform.rotated(by: CGFloat.pi))!
            }) { (comp) in
                self.titleView.isEnabled = true
        }
    }
    
    func right() {
        dismiss(animated: true)
    }
    
    func left()  {
        dismiss(animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    deinit {
        print("照片控制器被释放了")
    }
    func setupUI()  {
        
        navView.addSubview(leftBtn)
        navView.addSubview(rightBtn)
        navView.addSubview(titleView)
        
        view.addSubview(navView)
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        
        leftBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview().offset(10)
        }
        
        rightBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(leftBtn)
        }
        
        titleView.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftBtn)
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualTo(200)
        }
        
        navView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(UIConst.navHeight)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.right.left.bottom.equalToSuperview()
            make.top.equalTo(navView.snp.bottom)
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
            // album 自定义的相册如微博 QQ等
            let albumCollections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
            
            // smartAlbum 系统自带的相册。最近删除，最近添加等
            let smartAlbumCollection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
            
            self.photoCollections.append(albumCollections)
            self.photoCollections.append(smartAlbumCollection)
            
            for (_ , obj) in self.photoCollections.enumerated(){
                obj.enumerateObjects({ (collection, _, _) in
                    
                    let result = PHAsset.fetchAssets(in: collection, options: nil)
                    if collection.assetCollectionType == .album { // album 自定义相册
                        let item = PhotoGroupItem(count: result.count, firstImg: result.firstObject, result: result, name: collection.localizedTitle!)
                        self.tableViewDatas.append(item)
                        
                    }else if collection.assetCollectionType == .smartAlbum { // smart album 系统自带的相册
                        if result.count > 0{ // 过滤掉没有图片的
                            let item = PhotoGroupItem(count: result.count, firstImg: result.firstObject, result: result, name: collection.localizedTitle!)
                            self.tableViewDatas.append(item)
                        }
                    }
                })
            }
            
            self.listView.addSubview(self.tableView)
            self.tableView.clickClosure = { (tableview, indexPath, item) in
                self.titleClick()
                self.configCollectionData(item: item)
                self.titleView.setTitle(item.name, for: .normal)
            }
            
            self.tableView.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
            self.tableView.datas = self.tableViewDatas
            print(self.tableViewDatas)
        }
    }

    
    func configCollectionData(item: PhotoGroupItem)  {
        if let result = item.result{
            var temp = [GridItem]()
            result.enumerateObjects({ (asset, idx, stop) in
                let item = GridItem(choosed: false, asset: asset, isCarmea: false)
                temp.append(item)
            })
//            let cameraItem = GridItem(choosed: false, asset: nil, isCarmea: true)
//            temp.insert(cameraItem, at: 0)
            gridItems = temp
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

typealias PhotoViewCollectionProtocol = PhotoViewController

extension PhotoViewCollectionProtocol: UICollectionViewDelegate , UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGridCell", for: indexPath) as! PhotoGridCell
        cell.item = gridItems[indexPath.item]
        
        cell.indexPath = indexPath
        cell.clickClosure = { (cell , idx) in
            if idx.item == 0{
                // 去照相
                return
            }
            
            // 在这里做单选 还是 多选的 操作
            if false { // 默认单选s
//                cell.isChoosed = true
//                self.choosedCell?.isChoosed = false
                self.choosedCell = cell
            }else{ // 多选
                let res = self.checkInChoosed(indexPath: idx)
                if(self.mutiChoosedIndex.count > 2) && (res.0 == false){ // 点的不是之前选的
                    print("最多选三张")
                    return
                }
//                cell.isChoosed = !cell.isChoosed
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



/**
func getImages(collection: PHAssetCollection) {
    
    // 相册个数 ，名称 这组的相片  第一张缩略图
    // 图片
    let result = PHAsset.fetchAssets(in: collection, options: nil)
    
    //        print("相册的名字 =\(collection.localizedTitle) 个数 = \(result.count)")
    // 自定义的相册即使没有图片 也要、 系统的相册没有图片就剔除掉
    
    print(collection.localizedTitle ?? "nil")
    
    if collection.localizedTitle == "Camera Roll"{
        let opt = PHImageRequestOptions()
        opt.deliveryMode = .highQualityFormat
        if result.count > 0{
            print("title = \(collection.localizedTitle) , count = \(result.count)")
            var arr = [UIImage]()
            result.enumerateObjects ({ (asset, idx, stop) in
                // 获取图片
                PHImageManager.default().requestImage(for: asset, targetSize:PhotoViewController.tgSize, contentMode: .default, options: opt, resultHandler: { (img, dict) in
                    if let i = img{
                        //                            self.images.append(i)
                        arr.append(i)
                        print(i.size)
                    }
                })
            })
        }
        
        DispatchQueue.main.after(delay: 3, execute: {
            // 刷新
            self.collectionView.reloadData()
        })
    }
} */
