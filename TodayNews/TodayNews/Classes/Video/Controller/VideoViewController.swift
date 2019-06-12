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
        
        
        
        
    }
    
    // 点击事件
    private func clickAction() {
        
        
        
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
