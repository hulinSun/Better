//
//  GroupTableView.swift
//  better
//
//  Created by Hony on 2016/11/22.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class GroupTableView: UITableView {
    
    var datas: [PhotoGroupItem]?{
        didSet{
            reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        register(UINib.init(nibName: "PhotoGroupCell", bundle: nil), forCellReuseIdentifier: "PhotoGroupCell")
        delegate = self
        dataSource = self
        separatorStyle = .none
    }
}

extension GroupTableView: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoGroupCell") as! PhotoGroupCell
        cell.item = datas?[indexPath.row]
        cell.backgroundColor = UIColor.random()
        return cell
    }
}
