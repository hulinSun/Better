//
//  HomeViewController.swift
//  better
//
//  Created by Hony on 2016/10/13.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    // MARK: - UI
    
    /// 初始化ui
    private func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(tableview)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - LAZY

    
    private lazy var tableview: UITableView = {
        
        let i = UITableView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) , style: .plain)
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

