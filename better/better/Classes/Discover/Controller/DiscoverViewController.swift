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
        view.backgroundColor = UIColor.white
        let v = DiscoverTitleView.discoverTitleView()
        v.width = 100
        v.height = 44
        navigationItem.titleView = v
        titleV = v
//        navigationController?.navigationBar.clipsToBounds = true

    }

    fileprivate var titleV: DiscoverTitleView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
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
