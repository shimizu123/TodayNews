//
//  RelatedVideoView.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/31.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RelatedVideoView: UIView {

    // 点击了查看更多
    var didSelectCheckMoreButton: (()->())?
    // 点击了 cell
    var didSelectCell: ((_ video: NewsModel)->())?
    
    private lazy var disposeBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.ym_registerCell(cell: RelatedVideoCell.self)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    // 是否展开 tableView
    var isUnfold = false
    // 头部
    private lazy var headerView = RelatedVideoHeaderView.loadViewFromNib()
    // 尾部
    private lazy var footerView = RelatedVideoFooterView.loadViewFromNib()
    // 视频详情
    var videoDetail = VideoDetail() {
        didSet {
            footerView.ad = videoDetail.ad
            tableView.height = CGFloat(videoDetail.related_video_section * 80)
            footerView.y = tableView.frame.maxY
            self.height = footerView.frame.maxY
            // 如果之前有数据，这里需要 reload 一下
            tableView.reloadData()
        }
    }
    // 当前视频数据
    var video = NewsModel() {
        didSet {
            headerView.video = video
            tableView.x = 0
            tableView.y = headerView.frame.maxY
            tableView.width = screenWidth
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 添加子视图
        self.addSubview(headerView)
        self.addSubview(tableView)
        self.addSubview(footerView)
        // 展开按钮点击
        headerView.foldButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
            UIView.animate(withDuration: 0.25, animations: {
                self?.tableView.y = self!.headerView.frame.maxY
                self?.footerView.y = self!.tableView.frame.maxY
            })
        }).disposed(by: disposeBag)
        // 查看更多
        footerView.moreButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
            self?.isUnfold = true
            UIView.animate(withDuration: 0.25, animations: {
                self?.tableView.height = CGFloat(self!.videoDetail.related_video_toutiao.count * 80)
            })
            self?.footerView.y = self!.tableView.frame.maxY
            self?.height = self!.footerView.frame.maxY
            self?.didSelectCheckMoreButton?()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension RelatedVideoView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoDetail.related_video_toutiao.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isUnfold { return 80 }
        return indexPath.row >= videoDetail.related_video_section ? 0 : 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as RelatedVideoCell
        cell.relatedVideo = videoDetail.related_video_toutiao[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCell?(videoDetail.related_video_toutiao[indexPath.row])
    }
    
}
