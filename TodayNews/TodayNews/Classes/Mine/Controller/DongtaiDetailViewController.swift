//
//  DongtaiDetailViewController.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/4/18.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import IBAnimatable
import SVProgressHUD

class DongtaiDetailViewController: UIViewController {
    
    // emoji 图标
    @IBOutlet weak var emojiButton: UIButton!
    /// 评论按钮
    @IBOutlet weak var commentButton: UIButton!
    /// 点赞按钮
    @IBOutlet weak var diggButton: UIButton!
    /// 分享按钮
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var commentView: AnimatableView!
    
    // 评论数据
    private var comments = [DongtaiComment]()
    
    var dongtai = UserDetailDongtai() {
        didSet {
            navigationBar.user = dongtai.user
            headerView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: dongtai.detailHeaderHeight)
            headerView.dongtai = dongtai
        }
    }
    
    // 懒加载 头部
    private lazy var headerView = DongtaiDetailHeaderView.loadViewFromNib()
    // 懒加载 导航栏
    private lazy var navigationBar = DongtaiNavigationBar.loadViewFromNib()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.keyWindow?.theme_backgroundColor = "colors.cellBackgroundColor"
        navigationController?.setNavigationBarHidden(false, animated: animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置 UI
        setupUI()
        // 点击事件
        selectedAction()
    }
    
    // 设置 UI
    func setupUI() {
        self.view.theme_backgroundColor = "colors.cellBackgroundColor"
        commentView.theme_backgroundColor = "colors.grayColor240"
        diggButton.theme_setImage("images.tab_like_24x24_", forState: .normal)
        shareButton.theme_setImage("images.tab_share_24x24_", forState: .normal)
        emojiButton.theme_setImage("images.tabbar_icon_emoji_24x24_", forState: .normal)
        commentButton.theme_setTitleColor("colors.black", forState: .normal)
        navigationItem.titleView = navigationBar
        // 判断是否是夜间
        MyThemeStyle.setupNavigationBarStyle(viewController: self, isNight: UserDefaults.standard.bool(forKey: isNight))
        // 添加 导航栏右侧按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: UserDefaults.standard.bool(forKey: isNight) ? "follow_title_profile_night_18x18_" : "follow_title_profile_18x18_"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        // 添加通知
        NotificationCenter.default.addObserver(self, selector: #selector(receiveDayOrNightButtonClicked), name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: nil)
        tableView.tableHeaderView = headerView
        tableView.ym_registerCell(cell: DongtaiCommentCell.self)
        SVProgressHUD.configuration()
        switch dongtai.item_type {
        case .commentOrQuoteOthers, .commentOrQuoteContent, .forwardArticle:
            tableView.mj_footer = RefreshAutoGifFooter(refreshingBlock: { [weak self] in
                // 获取用户详情其他类型的详情的评论数据
                NetworkTool.loadUserDetailQuoteDongtaiComents(id: self!.dongtai.id, offset: self!.comments.count, completionHandler: {
                    self?.reloadData(comments: $0)
                })
            })
        case .postContent:
            tableView.mj_footer = RefreshAutoGifFooter(refreshingBlock: { [weak self] in
                // 获取用户详情一般的详情的评论数据
                NetworkTool.loadUserDetailNormalDongtaiComents(groupId: Int(self!.dongtai.id_str)!, offset: self!.comments.count, count: 20, completionHandler: {
                    self?.reloadData(comments: $0)
                })
            })
        default:
            break
        }
        tableView.mj_footer.beginRefreshing()
    }
    
    // 刷新数据
    func reloadData(comments: [DongtaiComment]) {
        if tableView.mj_footer.isRefreshing { tableView.mj_footer.endRefreshing() }
        tableView.mj_footer.pullingPercent = 0.0
        if comments.count == 0 {
            tableView.mj_footer.endRefreshingWithNoMoreData()
            SVProgressHUD.showInfo(withStatus: "没有更多数据啦!")
            return
        }
        self.comments += comments
        tableView.reloadData()
    }
    

}

// MARK: - 点击事件
extension DongtaiDetailViewController {
    // 写评论覆盖的按钮点击
    @IBAction func coverButtonClicked(_ sender: UIButton) {
       popPostCommentView(isEmojiButtonSelected: false)
    }
    
    // 弹出 postCommentView
    func popPostCommentView(isEmojiButtonSelected: Bool) {
        let postCommentView = PostCommentView.loadViewFromNib()
        postCommentView.placeholderLabel.text = "优质评论将会被优先展示"
        postCommentView.isEmojiButtonSelected = isEmojiButtonSelected
        UIApplication.shared.keyWindow?.backgroundColor = .white
        UIApplication.shared.keyWindow?.addSubview(postCommentView)
    }
    
    
    /// emoji 按钮点击
    @IBAction func emojiButtonClicked(_ sender: UIButton) {
       popPostCommentView(isEmojiButtonSelected: true)
    }
    
    /// 点赞的按钮点击
    @IBAction func diggButtonClicked(_ sender: UIButton) {
        
    }
    
    /// 分享的按钮点击
    @IBAction func shareButtonClicked(_ sender: UIButton) {
        
    }
    
    // 导航栏右侧按钮点击
    @objc func rightBarButtonItemClicked() {
        
    }
    
    // 点击事件
    private func selectedAction() {
        // 点击了 点赞按钮
        headerView.didSelectDiggButton = { [weak self] in
            let userDiggVC = UserDiggViewController()
            userDiggVC.userId = $0.id
            self?.navigationController?.pushViewController(userDiggVC, animated: true)
        }
    }
    
    // 接收到了按钮点击的通知
    @objc func receiveDayOrNightButtonClicked(notification: Notification) {
        let selected = notification.object as! Bool
        // 判断是否是夜间
        MyThemeStyle.setupNavigationBarStyle(viewController: self, isNight: selected)
        // 添加 导航栏右侧按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: selected ? "new_more_titlebar_night_24x24_" : "new_more_titlebar_24x24_"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
    }
    
}

extension DongtaiDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as DongtaiCommentCell
        cell.comment = comments[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = comments[indexPath.row]
        let postCommentView = PostCommentView.loadViewFromNib()
        if comment.screen_name != "" {
            postCommentView.placeholderLabel.text = "回复 \(comment.screen_name):"
        } else if comment.user.user_id != 0 {
            if comment.user.screen_name != "" {
                postCommentView.placeholderLabel.text = "回复 \(comment.user.screen_name):"
            }
        }
        self.view.addSubview(postCommentView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        navigationBar.titleLabel.isHidden = offsetY >= 50
        navigationBar.nameButton.isHidden = offsetY <= 50
        navigationBar.avatarButton.isHidden = offsetY <= 50
        navigationBar.vImageView.isHidden = offsetY <= 50
        navigationBar.followersButton.isHidden = offsetY <= 50
    }
}
