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
    }
  
    
    fileprivate lazy var tableView: UITableView = {
        
        let i = UITableView(frame: CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: UIConst.screenHeight), style: .plain)
        i.register(DiscoverArticleCell.self, forCellReuseIdentifier: "DiscoverArticleCell")
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
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscoverArticleCell") as! DiscoverArticleCell
        
         cell.topic = datas?[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas?.count ?? 0
    }
    
}
