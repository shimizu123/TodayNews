//
//  HomeViewController.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/2/26.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import SGPagingView

class HomeViewController: UIViewController {
    
    // 标题和内容
    var pageTitleView: SGPageTitleView?
    var pageContentView: SGPageContentScrollView?
    
    // 自定义导航栏
    private lazy var navigationBar = HomeNavigationView.loadViewFromNib()
    
    // 添加频道按钮
    private lazy var addChannelButton: UIButton = {
        let addChannelButton = UIButton(frame: CGRect(x: screenWidth - newsTitleHeight, y: 0, width: newsTitleHeight, height: newsTitleHeight))
        addChannelButton.theme_setImage("images.add_channel_titlbar_thin_new_16x16_", forState: .normal)
        let separatorView = UIView(frame: CGRect(x: 0, y: newsTitleHeight - 1, width: newsTitleHeight, height: 1))
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        addChannelButton.addSubview(separatorView)
        return addChannelButton
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.keyWindow?.theme_backgroundColor = "colors.windowColor"
        // 设置状态栏属性
        navigationController?.navigationBar.barStyle = .black
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: UserDefaults.standard.bool(forKey: isNight) ? "navigation_background_night" : "navigation_background"), for: .default)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置 UI
        setupUI()
    }

    
    private func setupUI() {
        self.view.theme_backgroundColor = "colors.cellBackgroundColor"
        // 设置自定义导航栏
        navigationItem.titleView = navigationBar
        // 添加频道
        self.view.addSubview(addChannelButton)
        // 首页顶部新闻标题的数据
        NetworkTool.loadHomeNewsTitleData {
            // 向数据库中插入数据
            NewsTitleTable().insert(titles: $0)
            let configure = SGPageTitleViewConfigure()
            configure.titleColor = .black
            configure.titleSelectedColor = UIColor.globalRedColor()
            configure.indicatorColor = .clear
            // 标题名称的数组
            self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: 0, width: screenWidth - newsTitleHeight, height: newsTitleHeight ), delegate: self, titleNames: $0.flatMap({ $0.name }), configure: configure)
            self.pageTitleView?.backgroundColor = .clear
            self.view.addSubview(self.pageTitleView!)
            // 设置子控制器
            _ = $0.flatMap({ (newsTitle) -> () in
                switch newsTitle.category {
                case .video:
                    let videoTableVC = VideoTableViewController()
                    
                    self.addChildViewController(videoTableVC)
                case .essayJoke:  // 段子
                    let essayJokeVC = HomeJokeViewController()
                    
                    self.addChildViewController(essayJokeVC)
                case .imagePPMM:  // 街拍
                    let imagePPMMVC = HomeJokeViewController()
                    
                    self.addChildViewController(imagePPMMVC)
                case .imageFunny: // 趣图
                    let imageFunnyVC = HomeJokeViewController()
                    
                    self.addChildViewController(imageFunnyVC)
                case .photos:     // 图片,组图
                    let photosVC = HomeImageViewController()
                    
                    self.addChildViewController(photosVC)
                case .jinritemai: // 特卖
                    let temaiVC = TeMaiViewController()
                    temaiVC.url = "https://m.maila88.com/mailaIndex?mailaAppKey=GDW5NMaKQNz81jtW2Yuw2P"
                    self.addChildViewController(temaiVC)
                default:
                    let homeTableVC = HomeRecommendController()
                    
                    self.addChildViewController(homeTableVC)
                }
            })
            
        }
    }
}

extension HomeViewController: SGPageTitleViewDelegate, SGPageContentScrollViewDelegate {
    // 联动 pageContent 的方法
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        self.pageContentView?.setPageContentScrollViewCurrentIndex(selectedIndex)
    }
    
    // 联动 SGPageTitleView 的方法
    func pageContentScrollView(_ pageContentScrollView: SGPageContentScrollView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView?.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
