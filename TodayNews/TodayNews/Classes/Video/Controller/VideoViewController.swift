//
//  VideoViewController.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/2/26.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import SGPagingView

class VideoViewController: UIViewController {
    
    // 标题和内容
    private var pageTitleView: SGPageTitleView?
    private var pageContentView: SGPageContentScrollView?
    
    // 自定义导航栏
    private lazy var navigationBar = HomeNavigationView.loadViewFromNib()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background" + (UserDefaults.standard.bool(forKey: isNight) ? "_night" : "")), for: .default)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置 UI
        setupUI()
        // 点击事件
        clickAction()
    }

    // 设置 UI
    private func setupUI() {
        self.view.theme_backgroundColor = "colors.cellBackgroundColor"
        // 设置自定义导航栏
        navigationItem.titleView = navigationBar
        // 视频顶部新闻标题的数据
        NetworkTool.loadVideoApiCategories {
            let configuration = SGPageTitleViewConfigure()
            configuration.titleColor = .black
            configuration.titleSelectedColor = UIColor.globalRedColor()
            configuration.indicatorColor = .clear
            // 标题名称的数组
            self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: newsTitleHeight), delegate: self, titleNames: $0.flatMap({ $0.name }), configure: configuration)
            self.pageTitleView?.backgroundColor = .clear
            self.view.addSubview(self.pageTitleView!)
            // 设置子控制器
            _ = $0.flatMap({ (newsTitle) -> () in
                let videoTableVC = VideoTableViewController()
                videoTableVC.setupRefresh(with: newsTitle.category)
                self.addChildViewController(videoTableVC)
            })
            // 内容视图
            self.pageContentView = SGPageContentScrollView(frame: CGRect(x: 0, y: newsTitleHeight, width: screenWidth, height: self.view.height - newsTitleHeight), parentVC: self, childVCs: self.childViewControllers)
            self.pageContentView?.delegatePageContentScrollView = self
            self.view.addSubview(self.pageContentView!)
        }
    }
    
    // 点击事件
    private func clickAction() {
        // 搜索按钮点击
        navigationBar.didSelectSearchButton = {
            
        }
        // 头像按钮点击
        navigationBar.didSelectAvatarButton = {
            self.navigationController?.pushViewController(MineViewController(), animated: true)
        }
    }

}

extension VideoViewController: SGPageTitleViewDelegate, SGPageContentScrollViewDelegate {
    // 联动 pageContent 的方法
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        self.pageContentView?.setPageContentScrollViewCurrentIndex(selectedIndex)
    }
    
    // 联动 SGPageTitleView 的方法
    func pageContentScrollView(_ pageContentScrollView: SGPageContentScrollView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView?.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
