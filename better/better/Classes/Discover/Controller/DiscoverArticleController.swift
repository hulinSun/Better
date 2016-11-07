//
//  DiscoverArticleController.swift
//  better
//
//  Created by Hony on 2016/11/7.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

/// 发现页文章界面控制器
class DiscoverArticleController: UIViewController {

    var datas: [Topic]?{
        didSet{
            tableView.reloadData()
        }
    }
    
    fileprivate lazy var tableView: UITableView = {
        let i = UITableView(frame: CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: UIConst.screenHeight), style: .plain)
        i.register(UINib.init(nibName: "DiscoverArticleCell", bundle: nil), forCellReuseIdentifier: "DiscoverArticleCell")
        i.separatorStyle = .none
        i.delegate = self
        i.dataSource = self
        return i
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    fileprivate func setupUI(){
        view.addSubview(tableView)
        view.backgroundColor = UIColor.white
        DiscoverHttpHelper.requestDiscoverData { (discover) in
            self.datas = discover.data?.topic
        }
    }
}



typealias TableViewProtocol = DiscoverArticleController

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

