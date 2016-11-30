//
//  PhotoFilterController.swift
//  better
//
//  Created by Hony on 2016/11/30.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import GPUImage
import AVFoundation

class PhotoFilterController: UIViewController {

    
    fileprivate lazy var imgView: UIImageView = {
        let i = UIImageView()
        return i
    }()
    
    fileprivate lazy var filterBar: PhotoFilterBar = {
        let i = PhotoFilterBar.loadFromNib()
        return i
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    var img: UIImage!{
        didSet{
            imgView.image = img
            filterBar.img = img
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setupUI(){
        view.backgroundColor = .white
        view.addSubview(filterBar)
        view.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(UIConst.screenHeight - 290.0)
        }
        self.navigationController?.navigationBar.isHidden = true
        filterBar.leftClickClo = {[unowned self] in
            let _ = self.navigationController?.popViewController(animated: true)
        }
        filterBar.snp.makeConstraints { (make) in
            make.right.left.bottom.equalToSuperview()
            make.height.equalTo(290)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "", style: .done, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
