//
//  HomeViewController.swift
//  better
//
//  Created by Hony on 2016/10/13.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import Kingfisher

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    var data: HomePageModel?{
        didSet{
            tableview.reloadData()
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.delegate = self
        navigationController?.navigationBar.shadowImage = UIImage()
        scrollViewDidScroll(tableview)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableview.delegate = nil
        navigationController?.navigationBar.lt_reset()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let color = UIColor.white
        let offsetY = scrollView.contentOffset.y
        if offsetY > CGFloat(50) {
            let alph = min(1, 1 - (CGFloat(50) + CGFloat(64) - offsetY) / CGFloat(64))
            navigationController?.navigationBar.lt_setBackgroundColor(color.withAlphaComponent(alph))
            navigationController?.navigationBar.shadowImage = nil
        }else{
            navigationController?.navigationBar.lt_setBackgroundColor(color.withAlphaComponent(0))
            navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
    
    
    // MARK: - UI

    /// 初始化ui
    private func setupUI() {

        navigationItem.leftBarButtonItem = clearLeftItem
        navigationItem.rightBarButtonItem = clearRightItem
        view.backgroundColor = UIColor.white
        view.addSubview(tableview)
        navigationController?.navigationBar.lt_setBackgroundColor(UIColor.clear)
        tableview.addBetterRefreshHeader {
            print("下拉刷新")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: { 
                self.tableview.betterHeader?.endRefreshing()
            })
        }
        tableview.tableHeaderView = headContainView
        
        HomeHttpHelper.requestHomeData { (model) in
            self.data = model
            if let ban = model.data?.banner {
                let b = ban.flatMap{$0.photo}
            let p = WirelessPictureView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 220), networkImageArray: b)
                p.autoScroll = true
                p.currentPageIndicatorTintColor = UIConst.yellowPageColor
                p.pageIndicatorTintColor = UIConst.grayPageColor
                p.timeInterval = 5
                self.headContainView.addSubview(p)
                self.headView = p
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - LAZY
    fileprivate var headView: WirelessPictureView!
    
    private lazy var headContainView: UIView = {
        let i = UIView()
        i.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 220)
        return i
    }()
    
    private lazy var tableview: UITableView = {
        
        let i = UITableView(frame:CGRect(x: 0, y: -64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) , style: .plain)
        i.delegate = self
        i.dataSource = self
        i.register( UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        return i
    }()
    
    /// 透明状态下 左item
    fileprivate lazy var clearLeftItem: UIBarButtonItem = {
        let searc = UIBarButtonItem.init(imageName: "home_search_icon", target: self, action: "searchClick")
        return searc
    }()
    
    
    /// 透明状态下 右item
    fileprivate lazy var clearRightItem: UIBarButtonItem = {
        let searc = UIBarButtonItem.init(imageName: "home_sign_icon", target: self, action: "giftClearClick")
        return searc
    }()
    
    /// 有导航栏状态下 右item
    fileprivate lazy var whiteRightItem: UIBarButtonItem = {
        let searc = UIBarButtonItem.init(imageName: "home_sign_top_icon", target: self, action: "giftClearClick")
        return searc
    }()
    
    func searchClick() {
        print("点击了搜索")
    }
    
    func giftClearClick() {
        print("点击了右边礼物")
    }
}


typealias TableViewDataSource = HomeViewController

extension TableViewDataSource : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 268
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
        cell.topic = data?.data?.topic?[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let c = data?.data?.topic?.count {
            return c
        }else{
            return 0
        }
    }
}

