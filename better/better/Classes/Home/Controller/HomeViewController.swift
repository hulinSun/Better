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

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
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
        view.backgroundColor = UIColor.white
        view.addSubview(tableview)
        tableview.tableHeaderView = headImage
        navigationController?.navigationBar.lt_setBackgroundColor(UIColor.clear)
        
        tableview.addBetterRefreshHeader {
            print("下拉刷新")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: { 
                self.tableview.betterHeader?.endRefreshing()
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - LAZY
    
    
    private lazy var headImage: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "bg")
        i.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
        return i
    }()
    
    private lazy var tableview: UITableView = {
        
        let i = UITableView(frame:CGRect(x: 0, y: -64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) , style: .plain)
        i.delegate = self
        i.dataSource = self
        i.register(UITableViewCell.self, forCellReuseIdentifier: "x")
        return i
    }()
}


typealias TableViewDataSource = HomeViewController

extension TableViewDataSource : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "x")!
        cell.textLabel?.text = "呵呵 😑" + "  \(indexPath.row)  "
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    
}

