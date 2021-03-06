//
//  PhotoViewController.swift
//  better
//
//  Created by Hony on 2016/10/14.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import GPUImage
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
    var indexPath: IndexPath?
    
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

    
    var camera: Camera!
    
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
    
    /// 单选情况下 选中的item
    var choonsedItem: GridItem?
    
    fileprivate lazy var mutiChoosedIndex: [IndexPath] = {
        let i = [IndexPath]()
        return i
    }()
    
    fileprivate lazy var tableView: GroupTableView = {
        let i = GroupTableView.init(frame: .zero, style: .plain)
        return i
    }()
    
    fileprivate lazy var titleView: PhotoTitleView = {
        let i = PhotoTitleView()
        i.setTitle("哈哈信息", for: .normal)
        i.addTarget(self, action: #selector(titleClick), for: .touchUpInside)
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
        i.setTitleColor( UIColor.rgb(red: 100, green: 100, blue: 100), for: .normal)
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
    
    var lastItem: GridItem?
    
    /// 点击按钮
    func titleClick(){
        
        view.addSubview(listView)
        listView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(320)
            make.bottom.equalTo(view.snp.top)
        }
        
        titleView.isEnabled = false
        titleView.isSelected = !titleView.isSelected
        listView.isHidden = false
        
        if titleView.isSelected {
            UIView.animate(withDuration: 0.25, animations: {
                self.listView.transform = CGAffineTransform.init(translationX: 0, y: 384)
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
        
        if let line = UINavigationBar.getLine(view: (navigationController?.navigationBar)!){
            line.isHidden = true
        }
        
        leftBtn.bt_width = 36
        leftBtn.bt_height = 20
        let leftItem = UIBarButtonItem.init(customView: leftBtn)
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.titleView = titleView
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        titleView.snp.makeConstraints { (make) in
            make.width.lessThanOrEqualTo(250)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.right.left.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        
    }
    
    func getCollection() {
        
        // 判断授权状态
        PHPhotoLibrary.requestAuthorization { (status) in
            if status != .authorized{
                print("用户没有授权。想办法搞一搞事情")
                return
            }
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
//            if let camealItem = self.tableViewDatas.filter({ (item) -> Bool in
//                return item.name == "Camera Roll"
//            }).first{
//                print(camealItem)
//                self.configCollectionData(item: camealItem)
//            }
            if let firstItem = self.tableViewDatas.first{
                self.configCollectionData(item: firstItem)
                self.titleView.setTitle(firstItem.name, for: .normal)
            }
        }
    }

    
    func configCollectionData(item: PhotoGroupItem)  {
        if let result = item.result{
            var temp = [GridItem]()
            result.enumerateObjects({ (asset, idx, stop) in
                let item = GridItem(choosed: false, asset: asset, isCarmea: false)
                temp.append(item)
            })
            let cameraItem = GridItem(choosed: false, asset: nil, isCarmea: true)
            temp.insert(cameraItem, at: 0)
            gridItems = temp
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

typealias PhotoViewCollectionProtocol = PhotoViewController

extension PhotoViewCollectionProtocol: UICollectionViewDelegate , UICollectionViewDataSource, UIScrollViewDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGridCell", for: indexPath) as! PhotoGridCell
        let model = gridItems[indexPath.item]
        model.indexPath = indexPath
        cell.item = model
        cell.clickClosure = { (cell , idx) in
            self.cellClickDeal(cell: cell, idx: idx)
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
    
    /// 处理cell 的点击
    func cellClickDeal(cell: PhotoGridCell, idx: IndexPath)  {
        
        if idx.item == 0 { // 打开照相机
            do {
                camera = try Camera(sessionPreset:AVCaptureSessionPreset640x480)
//                let filter = SaturationAdjustment()
                // FIXME: 日你奶奶
//                camera --> filter --> renderView
//                camera.startCapture()
            } catch {
                fatalError("Could not initialize rendering pipeline: \(error)")
            }
        }else{
            let edit = PhotoEditController()
            let im = self.gridItems[idx.item]
            if let asst = im.asset{
                asst.fitImage(callBack: { (img, info) in
                    edit.photoSize = asst.fitSize()
                    edit.img = img
                    self.navigationController?.pushViewController(edit, animated: true)
                })
            }
        }
        return
        if self.titleView.isSelected{
            self.titleClick()
        }
        
        if idx.item == 0{ return }// 去照相
        let itemModel = self.gridItems[idx.item]
        // 在这里做单选 还是 多选的 操作
        if 2 > 1 { // 默认单选
            itemModel.choosed = !itemModel.choosed
            self.lastItem?.choosed = !(self.lastItem?.choosed)!
            cell.item = itemModel
            if self.lastItem != nil{
                if let lastCell = collectionView.cellForItem(at: (self.lastItem?.indexPath)!) as? PhotoGridCell{
                    lastCell.item =  self.lastItem
                }
            }
            self.lastItem = itemModel
        }else{ // 多选
            let res = self.checkInChoosed(indexPath: idx)
            if(self.mutiChoosedIndex.count > 2) && (res.0 == false){
                // 点的不是之前选的
                print("最多选三张"); return
            }
            itemModel.choosed = !itemModel.choosed
            cell.item = itemModel
            if res.0 == true{ // 在数组中
                self.mutiChoosedIndex.remove(at: res.1)
            }else{
                self.mutiChoosedIndex.append(idx)
            }
            print(self.mutiChoosedIndex)
        }
    }
}

