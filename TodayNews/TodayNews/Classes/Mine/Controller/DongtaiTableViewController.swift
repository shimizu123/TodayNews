//
//  DongtaiTableViewController.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/3/26.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import SVProgressHUD

class DongtaiTableViewController: UITableViewController {
    
    // 刷新的指示器
    var maxCursor = 0
    var wendaCursor = ""
    // 点击了 用户名
    var didSelectHeaderUserId: ((_ uid: Int)->())?
    // 点击了 话题
    var didSelectHeaderTopicId: ((_ cid: Int)->())?
    
    
    
    
    // 当前的 toptab 的类型
    var currentTopTabType: TopTabType = .dongtai {
        didSet {
            switch currentTopTabType { // 如果已经显示过了，就不再刷新数据了
            case .dongtai:  // 动态
                if !isDongtaisShown {
                    isDongtaisShown = true
                    // 设置 footer
                    setupFooter(tableView: self.tableView, completionHandler: {
                        self.dongtais += $0
                        self.tableView.reloadData()
                    })
                    tableView.mj_footer.beginRefreshing()
                }
            case .article:  // 文章
                if !isArticlesShown {
                    isArticlesShown = true
                    // 设置 footer
                    setupFooter(tableView: self.tableView, completionHandler: {
                        self.articles += $0
                        self.tableView.reloadData()
                    })
                    tableView.mj_footer.beginRefreshing()
                }
            case .video:    // 视频
                if !isVideosShown {
                    isVideosShown = true
                    // 设置 footer
                    setupFooter(tableView: self.tableView, completionHandler: {
                        self.videos += $0
                        self.tableView.reloadData()
                    })
                    tableView.mj_footer.beginRefreshing()
                }
            case .wenda:    // 问答
                if !isWendasShown {
                    isWendasShown = true
                    tableView.ym_registerCell(cell: UserDetailWendaCell.self)
                    tableView.mj_footer = RefreshAutoGifFooter(refreshingBlock: { [weak self] in
                        // 获取用户详情的问答列表更多数据
                        NetworkTool.loadUserDetailLoadMoreWendaList(userId: self!.userId, cursor: self!.wendaCursor, completionHandler: {
                            if self!.tableView.mj_footer.isRefreshing { self!.tableView.mj_footer.endRefreshing() }
                            self!.tableView.mj_footer.pullingPercent = 0
                            if $1.count == 0 {
                                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
                                SVProgressHUD.showInfo(withStatus: "没有更多数据啦!")
                                return
                            }
                            self?.wendaCursor = $0
                            self?.wendas += $1
                            self?.tableView.reloadData()
                        })
                    })
                    tableView.mj_footer.beginRefreshing()
                }
            case .iesvideo:   // 小视频
                if !isiesVideosShown {
                    isiesVideosShown = true
                    // 设置 footer
                    setupFooter(tableView: self.tableView, completionHandler: {
                        self.iesVideos += $0
                        self.tableView.reloadData()
                    })
                    tableView.mj_footer.beginRefreshing()
                }
            }
        }
    }
    
    // 动态数据 数组
    var dongtais = [UserDetailDongtai]()
    var articles = [UserDetailDongtai]()
    var videos = [UserDetailDongtai]()
    var wendas = [UserDetailWenda]()
    var iesVideos = [UserDetailDongtai]()
    // 记录当前的数据是否显示过
    var isDongtaisShown = false
    var isArticlesShown = false
    var isVideosShown = false
    var isWendasShown = false
    var isiesVideosShown = false
    
    
    // 用户编号
    var userId = 0
    
    // 设置 footer
    private func setupFooter(tableView: UITableView, completionHandler: @escaping (_ datas: [UserDetailDongtai])->()) {
        tableView.mj_footer = RefreshAutoGifFooter(refreshingBlock: { [weak self] in
            NetworkTool.loadUserDetailDongtaiList(userId: self!.userId, maxCursor: self!.maxCursor, completionHandler: {
                if tableView.mj_footer.isRefreshing { tableView.mj_footer.endRefreshing() }
                tableView.mj_footer.pullingPercent = 0
                if $1.count == 0 {
                    tableView.mj_footer.endRefreshingWithNoMoreData()
                    SVProgressHUD.showInfo(withStatus: "没有更多数据啦!")
                    return
                }
                self?.maxCursor = $0
                completionHandler($1)
            })
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.configuration()
        if isIphoneX { tableView.contentInset = UIEdgeInsetsMake(0, 0, 34, 0) }
        tableView.theme_backgroundColor = "colors.cellBackgroundColor"
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.bouncesZoom = false
        tableView.ym_registerCell(cell: UserDetailDongTaiCell.self)  
    }

    

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentTopTabType {
        case .dongtai:
            return dongtais.count
        case .article:
            return articles.count
        case .video:
            return videos.count
        case .wenda:
            return wendas.count
        case .iesvideo:
            return iesVideos.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch currentTopTabType {
        case .dongtai:
            return cellFor(tableView: tableView, at: indexPath, with: dongtais)
        case .article:
            return cellFor(tableView: tableView, at: indexPath, with: articles)
        case .video:
            return cellFor(tableView: tableView, at: indexPath, with: videos)
        case .wenda:
            let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as UserDetailWendaCell
            cell.wenda = wendas[indexPath.row]
            return cell
        case .iesvideo:
            return cellFor(tableView: tableView, at: indexPath, with: iesVideos)
        }
    }
    
    // 设置 cell
    private func cellFor(tableView: UITableView, at indexPath: IndexPath, with data: [UserDetailDongtai]) -> UserDetailDongTaiCell {
        let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as UserDetailDongTaiCell
        cell.dongtai = data[indexPath.row]
        cell.didSelectDongtaiUserName = {
            self.didSelectHeaderUserId?($0)
        }
        cell.didSelectDongtaiTopic = {
            self.didSelectHeaderTopicId?($0)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch currentTopTabType {
        case .dongtai:
            return dongtais[indexPath.row].cellHeight
        case .article:
            return articles[indexPath.row].cellHeight
        case .video:
            return videos[indexPath.row].cellHeight
        case .wenda:
            return wendas[indexPath.row].cellHeight
        case .iesvideo:
            return iesVideos[indexPath.row].cellHeight
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch currentTopTabType {
        case .dongtai:
            pushNextViewController(dongtai: dongtais[indexPath.row])
        case .article:
            pushNextViewController(dongtai: articles[indexPath.row])
        case .video:
            pushNextViewController(dongtai: videos[indexPath.row])
        case .wenda:
            SVProgressHUD.showInfo(withStatus: "sslocal 参数未知，无法获取数据！")
        case .iesvideo:
            pushNextViewController(dongtai: iesVideos[indexPath.row])
        }
    }
    
    // 跳转到下一个控制器
    private func pushNextViewController(dongtai: UserDetailDongtai) {
        switch dongtai.item_type {
        case .commentOrQuoteOthers, .commentOrQuoteContent, .forwardArticle, .postContent:
            let dongtaiDetailVC = DongtaiDetailViewController()
            dongtaiDetailVC.dongtai = dongtai
            navigationController?.pushViewController(dongtaiDetailVC, animated: true)
        case .postVideo, .postVideoOrArticle, .postContentAndVideo:
            SVProgressHUD.showInfo(withStatus: "跳转到视频控制器")
        case .proposeQuestion:
            let wendaVC = WendaViewController()
            wendaVC.qid = dongtai.id
            wendaVC.enterFrom = .dongtai
            navigationController?.pushViewController(wendaVC, animated: true)
        case .answerQuestion:
            SVProgressHUD.showInfo(withStatus: "sslocal 参数未知，无法获取数据！")
        case .postSmallVideo:
            SVProgressHUD.showInfo(withStatus: "请点击底部小视频 tabbar")
        }
    }
   
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 { //黏住顶部
            self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
}
