//
//  VideoDetailViewController.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/31.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import BMPlayer
import SnapKit
import SVProgressHUD

protocol VideoDetailViewControllerDelegate: class {
    // 详情控制器将要消失
    func VideoDetailViewControllerViewWillDisappear(realVideo: RealVideo, currentTime: TimeInterval, currentIndex: IndexPath)
}

class VideoDetailViewController: UIViewController {
    
    @IBOutlet weak var loveButton: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    weak var delegate: VideoDetailViewControllerDelegate?
    // 播放器
    lazy var player: BMPlayer = BMPlayer(customControlView: BMPlayerControlView())
    // 当前视频数据
    var video = NewsModel()
    // 评论数据
    private var comments = [DongtaiComment]()
    // 真实视频地址
    var realVideo = RealVideo()
    // 当前播放的时间
    var currentTime: TimeInterval = 0
    // 当前点击的索引
    var currentIndexPath = IndexPath(item: 0, section: 0)
    
    // 用户信息 view
    private lazy var userView = VideoDetailUserView.loadViewFromNib()
    // 相关新视频的 view
    private lazy var relatedVideoView = RelatedVideoView()
    // tableView
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.ym_registerCell(cell: DongtaiCommentCell.self)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    // 返回按钮
    lazy var backButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "personal_home_back_white_24x24_"), for: .normal)
        backButton.addTarget(self, action: #selector(clickBackButton), for: .touchUpInside)
        return backButton
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        delegate?.VideoDetailViewControllerViewWillDisappear(realVideo: realVideo, currentTime: currentTime, currentIndex: currentIndexPath)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置播放器，修改属性
        setupUI()
        // 获取数据
        loadNetwork(with: video)
        // 添加点击事件
        addAction()
    }
    
    // 设置播放器，修改属性
    private func setupUI() {
        loveButton.theme_setImage("images.love_video_20x20_", forState: .normal)
        loveButton.theme_setImage("images.love_video_press_20x20_", forState: .selected)
        
        player.delegate = self
        
        self.view.addSubview(player)
        self.view.addSubview(backButton)
        self.view.addSubview(userView)
        self.view.addSubview(tableView)
        
        player.snp.makeConstraints {
            $0.top.equalTo(self.view).offset(isIphoneX ? 40 : 0)
            $0.left.right.equalTo(self.view)
            $0.height.equalTo(self.view.snp.width).multipliedBy(9 / 16)
        }
        
        backButton.snp.makeConstraints {
            $0.left.equalTo(self.view).offset(10)
            $0.size.equalTo(CGSize(width: 35, height: 35))
            $0.top.equalTo(player.snp.top).offset(10)
        }
        
        userView.snp.makeConstraints {
            $0.top.equalTo(player.snp.bottom)
            $0.left.right.equalTo(self.view)
            $0.height.equalTo(45)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(userView.snp.bottom)
            $0.bottom.equalTo(bottomView.snp.top)
            $0.left.right.equalTo(self.view)
        }
    }
    
    // 获取数据
    private func loadNetwork(with video: NewsModel) {
        // 需要先获取视频的真实播放地址
        NetworkTool.parseVideoRealURL(video_id: video.video_detail_info.video_id) {
            self.realVideo = $0
            // 设置视频播放地址
            self.player.setVideo(resource: BMPlayerResource(url: URL(string: $0.video_list.video_1.mainURL)!))
            // 设置当前播放的时间
            self.player.seek(self.currentTime)
        }
        // 视频详情数据
        NetworkTool.loadArticleInformation(from: "click_video", itemId: video.item_id, groupId: video.group_id) {
            self.userView.userInfo = $0.user_info
            // 添加相关视频界面
            // 使用自定义 view，这里不使用添加子控制器的方式，可参考 RelatedVideoTableViewController
            self.relatedVideoView.video = self.video
            self.relatedVideoView.videoDetail = $0
            self.tableView.tableHeaderView = self.relatedVideoView
        }
        // 添加上拉刷新
        tableView.mj_footer = RefreshAutoGifFooter(refreshingBlock: { [weak self] in
            // 获取用户详情一般的详情的评论数据
            NetworkTool.loadUserDetailNormalDongtaiComents(groupId: self!.video.group_id, offset: self!.comments.count, count: 20, completionHandler: {
                if self!.tableView.mj_footer.isRefreshing { self!.tableView.mj_footer.endRefreshing() }
                self!.tableView.mj_footer.pullingPercent = 0.0
                if $0.count == 0 {
                    self?.tableView.mj_footer.endRefreshingWithNoMoreData()
                    SVProgressHUD.showInfo(withStatus: "没有更多数据啦!")
                    return
                }
                self?.comments += $0
                self?.tableView.reloadData()
            })
        })
        tableView.mj_footer.beginRefreshing()
    }
    
    deinit {
        
    }
    

}

// MARK: - 添加点击事件
extension VideoDetailViewController {
    
    // 添加点击事件
    private func addAction() {
        // 覆盖按钮点击
        
        
        
    }
    
    // 评论点击
    @IBAction func commentButtonClicked(_ sender: UIButton) {
        
    }
    /// 喜欢点击
    @IBAction func loveButtonClicked(_ sender: UIButton) {
        
    }
    
    // 分享点击
    @IBAction func shareButtonClicked(_ sender: UIButton) {
        
    }
    
    @objc func clickBackButton() {
        navigationController?.popViewController(animated: true)
    }

}

extension VideoDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
}

extension VideoDetailViewController: BMPlayerDelegate {
    
    func bmPlayer(player: BMPlayer ,playerStateDidChange state: BMPlayerState) {
        
    }
    
    func bmPlayer(player: BMPlayer ,loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        
    }
    
    func bmPlayer(player: BMPlayer ,playTimeDidChange currentTime : TimeInterval, totalTime: TimeInterval) {
        self.currentTime = currentTime
    }
    
    func bmPlayer(player: BMPlayer ,playerIsPlaying playing: Bool) {
        
    }
    
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        
    }
    
}
