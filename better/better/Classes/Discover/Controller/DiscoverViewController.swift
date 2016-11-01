//
//  DiscoverViewController.swift
//  better
//
//  Created by Hony on 2016/10/13.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    fileprivate var titleV: DiscoverTitleView!
    
    var datas: [Topic]?{
        didSet{
            tableView.reloadData()
        }
    }
    
    
    private func setupUI() {
        
        view.addSubview(tableView)
        view.backgroundColor = UIColor.white
        let v = DiscoverTitleView.discoverTitleView()
        v.width = 100 ; v.height = 44
        navigationItem.titleView = v ; titleV = v
        if let hairl = findHairlineImageViewUnder(view: navigationController!.navigationBar){
            hairl.isHidden = true
        }
        DiscoverHttpHelper.requestDiscoverData { (discover) in
            self.datas = discover.data?.topic
        }
        
        configNav()
    }
  
    
    fileprivate lazy var tableView: UITableView = {
        
        let i = UITableView(frame: CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: UIConst.screenHeight), style: .plain)
        
        i.register(UINib.init(nibName: "DiscoverArticleCell", bundle: nil), forCellReuseIdentifier: "DiscoverArticleCell")
        i.separatorStyle = .none
        i.delegate = self
        i.dataSource = self
        return i
    }()
    
    func findHairlineImageViewUnder(view: UIView) -> UIImageView? {
        if view is UIImageView && (view.height <= 1.0) {
            return view as? UIImageView
        }
        for subView in view.subviews{
            guard let img = findHairlineImageViewUnder(view: subView) else{
                return nil
            }
            return img
        }
        return nil
    }
    
}


typealias TableViewProtocol = DiscoverViewController

extension TableViewProtocol : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscoverArticleCell") as! DiscoverArticleCell
         cell.topic = datas?[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas?.count ?? 0
    }
    
}

// MARK: - configNav
extension DiscoverViewController{
    
    /// 初始化导航栏
    fileprivate func configNav() {
        
        let editItem = UIBarButtonItem.itemWith(icon: "discover_write_article_icon", highlightIcon: "discover_write_article_icon", target: self, action: #selector(DiscoverViewController.edit))
        navigationItem.rightBarButtonItem = editItem
        
        let leftItem = UIBarButtonItem.itemWithBack(icon: "discover_article_list_dark_icon", highlightIcon: "discover_article_list_icon", target: self, action: #selector(DiscoverViewController.leftClick))
        navigationItem.leftBarButtonItem = leftItem
    }
    
    func edit() {
       print("点击了编辑按钮")
    }
    
    func leftClick()  {
        print("点击了菜单按钮")
    }
    
}


