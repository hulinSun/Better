//
//  PlayerController.swift
//  better
//
//  Created by Hony on 2016/12/7.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class PlayerController: UIViewController {

    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    fileprivate lazy var playView: PlayerView = {
        let i = PlayerView()
        return i
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(playView)
        playView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
//            make.height.equalTo(UIConst.screenWidth * 0.75)
            make.height.equalTo(playView.snp.width).multipliedBy(0.75)
        }
    }
    
}
