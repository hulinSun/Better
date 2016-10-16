//
//  MainTabbarController.swift
//  better
//
//  Created by Hony on 2016/10/13.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildVCByJSON()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//
        tabBar.backgroundImage = UIImage(named: "tab_bar_bg")!
        // 重新布局
        let width = tabBar.bounds.width / 5
        photoBtn.frame = CGRect(x: CGFloat(2) * width, y: 0, width: 75, height: 49)
        
        for item in tabBar.subviews{
            let className: AnyClass? = NSClassFromString("UITabBarButton")
            if item.isKind(of: className!){
                for subItem in item.subviews{
//                    subItem.backgroundColor = UIColor.blue
                    print(subItem.frame)
//                   subItem.frame = CGRect(x: 0, y: 10, width: 25, height: 25)
                }
            }
        }
    }

    
    func photoClick() {
        print("点击了按钮")
        let photoVC = PhotoViewController()
        let nav = MainNavigationController(rootViewController : photoVC)
        selectedViewController?.present(nav, animated: true) // Swift 3 改变，可以省略后面的闭包 option 等参数
    }
    
    // MARK:- 懒加载
    
    private lazy var photoBtn: UIButton = {
        let i = UIButton()
//        tab_publish_add
        i.setImage(UIImage(named: "tab_publish_add")!, for: .normal)
        i.setImage(UIImage(named: "tab_publish_add_pressed")!, for: .highlighted)
        i.addTarget(self, action: #selector(photoClick), for: .touchUpInside)
        weak var weakSelf = self
        weakSelf!.tabBar.addSubview(i)
        return i
    }()
    
    
    // MARK:- 私有方法
    
    /// 初始化自控制器
    private func setupChildVCByJSON() {
        // 加载命名空间
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"]! as! String
        func addChildVCByItem(item: [String : AnyObject]){
            // ["imageName": tab_首页, "vcName": HomeViewController]
//            print(item)
            
            /**
             *  Swift有命名空间
             * 一般情况下命名空间就是项目的名称，如果想要改命名空间的名称，可以修改product name 这个plist 对应的值就ok
             * 动态加载命名空间: 通过info.plist 动态加载CFBundleExecutable的值
             */
            
            let vcName = item["vcName"]! as! String
            // 获取类名
            let nameClass : AnyClass? = NSClassFromString(nameSpace + "." + vcName)
                if let vcClass = nameClass as? UIViewController.Type{
                let vc = vcClass.init() // 创建子控制器
                let imageName = item["imageName"]! as! String // as! 确定有值
                
                let normoalImage = UIImage(named: imageName)
                let press = UIImage(named: imageName + "_pressed")
                vc.tabBarItem.image = normoalImage?.withRenderingMode(.alwaysOriginal)
                vc.tabBarItem.selectedImage = press?.withRenderingMode(.alwaysOriginal)
                let nav = MainNavigationController(rootViewController: vc)
                addChildViewController(nav)
            }
        }
        
        guard  let url = Bundle.main.url(forResource: "MainVCSettings.json", withExtension: nil) else { return }
        do {
            let jsonData = try Data(contentsOf: url)
            if let arr: [[String : AnyObject]] = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [[String: AnyObject]]{
                arr.forEach{addChildVCByItem(item: $0)} // 尾闭包
            }
        } catch {
            print("data 生成失败 \(error)")
        }
    }
}
