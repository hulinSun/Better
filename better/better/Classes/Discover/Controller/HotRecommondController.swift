//
//  HotRecommondController.swift
//  better
//
//  Created by Hony on 2016/11/7.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit


/// 热门控制器
class HotRecommondController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        DiscoverHttpHelper.requestDiscoverHot { (hot) in
            
        }
    }
    
    fileprivate lazy var tableView: UITableView = {
        let i = UITableView(frame: CGRect(x: 0, y: 0, width: UIConst.screenWidth, height: UIConst.screenHeight), style: .plain)
        i.separatorStyle = .none
        i.register(HotRecommondCell.self, forCellReuseIdentifier: "HotRecommondCell")
        i.delegate = self
        i.dataSource = self
        return i
    }()
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



typealias HotRecommandTableViewProtocol = HotRecommondController

extension HotRecommandTableViewProtocol : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotRecommondCell") as! HotRecommondCell
        
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}
