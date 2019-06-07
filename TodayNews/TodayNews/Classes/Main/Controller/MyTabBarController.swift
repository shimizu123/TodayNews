//
//  MyTabBarController.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/2/26.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = UITabBar.appearance()
        tabbar.theme_tintColor = "colors.tabbarTintColor"
        tabbar.theme_barTintColor = "colors.cellBackgroundColor"
        // 添加子控制器
        addChildViewControllers()
        NotificationCenter.default.addObserver(self, selector: #selector(receiveDayOrNightButtonClicked), name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: nil)
    }
    
    // 接收到了按钮点击的通知
    @objc func receiveDayOrNightButtonClicked(notification: Notification) {
        let selected = notification.object as! Bool
        if selected { // 设置为夜间
            for childNavController in self.childViewControllers {
                switch childNavController.title! {
                case "首页":
                    setNightChildController(controller: childNavController, imageName: "home")
                case "西瓜视频":
                    setNightChildController(controller: childNavController, imageName: "video")
                case "小视频":
                    setNightChildController(controller: childNavController, imageName: "huoshan")
                case "微头条":
                    setNightChildController(controller: childNavController, imageName: "weitoutiao")
                case "":
                    setNightChildController(controller: childNavController, imageName: "redpackage")
                default:
                    break
                }
            }
        } else { // 设置为日间
            for childNavController in self.childViewControllers {
                switch childNavController.title! {
                case "首页":
                    setDayChildController(controller: childNavController, imageName: "home")
                case "西瓜视频":
                    setDayChildController(controller: childNavController, imageName: "video")
                case "小视频":
                    setDayChildController(controller: childNavController, imageName: "huoshan")
                case "微头条":
                    setDayChildController(controller: childNavController, imageName: "weitoutiao")
                case "":
                    setDayChildController(controller: childNavController, imageName: "redpackage")
                default:
                    break
                }
            }
        }
        
        
    }
    
    // 设置夜间控制器
    func setNightChildController(controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_night_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_night_32x32_")
    }
    
    // 设置日间控制器
    func setDayChildController(controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_32x32_")
    }

    // 添加子控制器
    func addChildViewControllers() {
        setChildViewController(HomeViewController(), title: "首页", imageName: "home")
        setChildViewController(VideoViewController(), title: "西瓜视频", imageName: "video")
        setChildViewController(RedPackageViewController(), title: "", imageName: "redpackage")
        setChildViewController(HuoShanViewController(), title: "微头条", imageName: "huoshan")
        setChildViewController(MineViewController(), title: "我的", imageName: "mine")
        
        // tabBar 是 readonly 属性，不能直接修改，利用 KVC 把 readonly 属性的权限改过来
     //   setValue(MyTabBar(), forKey: "tabBar")
    }
    
    
    // 初始化子控制器
    private func setChildViewController(_ childController: UIViewController, title: String, imageName: String) {
        // 设置 tabbar 文字和图片
        if UserDefaults.standard.bool(forKey: isNight) {
            setNightChildController(controller: childController, imageName: imageName)
        } else {
            setDayChildController(controller: childController, imageName: imageName)
        }
        childController.title = title
        // 添加导航控制器为 TabBarController 的子控制器
        let navVC = MyNavigationController(rootViewController: childController)
        self.addChildViewController(navVC)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
