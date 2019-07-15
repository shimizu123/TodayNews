//
//  HomeCell.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/18.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import IBAnimatable

class HomeCell: UITableViewCell, RegisterCellFromNib {
    
    // 标题顶部图
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var thumbImageViewHeight: NSLayoutConstraint!
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 广告
    @IBOutlet weak var adOrHotLabel: AnimatableLabel!
    @IBOutlet weak var adOrHotLabelWidth: NSLayoutConstraint!
    /// 名称
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameLabelLeading: NSLayoutConstraint!
    /// 评论数量
    @IBOutlet weak var commentCountLabel: UILabel!
    /// 评论数量
    @IBOutlet weak var publishTimeLabel: UILabel!
    /// 右侧图片
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var rightImageViewWidth: NSLayoutConstraint!
    /// 右侧时长
    @IBOutlet weak var rightTimeButton: UIButton!
    @IBOutlet weak var rightTimeButtonWidth: NSLayoutConstraint!
    /// 关闭按钮，不感兴趣
    @IBOutlet weak var addTextpageButton: UIButton!
    /// 中间 view
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var middleViewHeight: NSLayoutConstraint!
    /// 底部 view
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    /// 底部标题
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    // 关闭按钮点击，不感兴趣
    @IBAction func addTextpageButtonClicked(_ sender: UIButton) {
        
    }
    
    /// 下载按钮点击
    @IBAction func downloadButtonClicked(_ sender: UIButton) {
        
    }
    
    var aNews = NewsModel() {
        didSet {
            downloadButton.setImage(nil, for: .normal)
            topImageView.image = nil
            rightImageView.image = nil
            videoImageButton.setImage(nil, for: .normal)
            collectionView.removeFromSuperview()
            if middleView.subviews.count != 0 {
                videoImageButton.removeFromSuperview()
            }
            bottomViewHeight.constant = 0
            downloadButton.setTitle("", for: .normal)
            
            titleLabel.text = aNews.title
            if aNews.media_name != "" {
                nameLabel.text = aNews.media_name
            } else if aNews.media_info.media_id != 0 {
                nameLabel.text = aNews.media_info.name
            } else if aNews.user_info.user_id != 0 {
                nameLabel.text = aNews.user_info.name
            }
            commentCountLabel.text = aNews.comment_count == 0 ? "" : aNews.commentCount + "评论"
            publishTimeLabel.text = aNews.publishTime
            // 设置广告标签
            adOrHotLabel.textColor = UIColor.globalRedColor()
            adOrHotLabel.borderColor = UIColor.globalRedColor()
            adOrHotLabel.text = aNews.label
            if aNews.hot {
                adOrHotLabel.text = "热"
                adOrHotLabelWidth.constant = 20
                nameLabelLeading.constant = 5
            } else if aNews.is_stick || aNews.label == "直播" || aNews.label == "影视" {
                setupAdLabel()
            } else if aNews.label_style == .ad { // 广告
                adOrHotLabel.textColor = UIColor.blueFontColor()
                adOrHotLabel.borderColor = UIColor.lightGray
                setupAdLabel()
                if aNews.sub_title != "" {
                    subTitleLabel.text = aNews.sub_title
                    bottomViewHeight.constant = 40
                    downloadButton.setImage(UIImage(named: "download_ad_feed_13x13_"), for: .normal)
                }
            } else {
                adOrHotLabel.text = ""
                adOrHotLabelWidth.constant = 0
                nameLabelLeading.constant = 0
            }
            if aNews.has_video && aNews.video_duration != 0 { // 有视频
                if aNews.video_style == 0 { // 右侧有图
                    rightTimeButton.setTitle(aNews.videoDuration, for: .normal)
                    rightTimeButtonWidth.constant = 50
                    if let image = aNews.image_list.first {
                        rightImageView.kf.setImage(with: URL(string: image.urlString))
                    } else if aNews.middle_image.url.length > 0 {
                        rightImageView.kf.setImage(with: URL(string: aNews.middle_image.urlString))
                    } else if let largeImage = aNews.large_image_list.first {
                        rightImageView.kf.setImage(with: URL(string: largeImage.urlString))
                    }
                    rightImageViewWidth.constant = screenWidth * 0.28
                } else if aNews.video_style == 2 { // 大图
                    middleViewHeight.constant = screenWidth / 2
                    if let largeImage = aNews.large_image_list.first {
                        videoImageButton.setImage(UIImage(named: "video_play_icon_44x44_"), for: .normal)
                        videoImageButton.kf.setBackgroundImage(with: URL(string: largeImage.urlString), for: .normal)
                    }
                    videoImageButton.frame = CGRect(x: 0, y: 0, width: middleView.width, height: screenWidth / 2)
                    middleView.addSubview(videoImageButton)
                    setupRightImageView()
                }
            } else { // 没有视频
                if aNews.middle_image.url != "" && aNews.image_list.count == 0 {
                    rightImageView.kf.setImage(with: URL(string: aNews.middle_image.urlString))
                    rightImageViewWidth.constant = screenWidth * 0.28
                }else {
                    setupRightImageView()
                    if aNews.image_list.count == 1 { // 右侧显示图片
                        rightImageView.kf.setImage(with: URL(string: aNews.image_list.first!.urlString))
                        rightImageViewWidth.constant = screenWidth * 0.28
                    } else { //多张图片
                        middleViewHeight.constant = image3Width
                        collectionView.frame = CGRect(x: 0, y: 0, width: screenWidth - 30, height: image3Width)
                        collectionView.images = aNews.image_list
                        middleView.addSubview(collectionView)
                    }
                }
            }
            layoutIfNeeded()
        }
    }
    
    private func setupRightImageView() {
        rightTimeButtonWidth.constant = 0
        rightImageViewWidth.constant = 0
        rightTimeButton.setTitle("", for: .normal)
    }
    
    private func setupAdLabel() {
        adOrHotLabelWidth.constant = 32
        nameLabelLeading.constant = 5
    }
   

    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        titleLabel.theme_textColor = "colors.black"
        nameLabel.theme_textColor = "colors.grayColor150"
        commentCountLabel.theme_textColor = "colors.grayColor150"
        addTextpageButton.theme_setImage("images.add_textpage_17x12_", forState: .normal)
        rightTimeButton.theme_setImage("images.palyicon_video_textpage_6x8_", forState: .normal)
        downloadButton.theme_setImage("images.download_ad_feed_13x13_", forState: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // 懒加载 collectionView
    private lazy var collectionView = HomeImageCollectionView.loadViewFromNib()
    
    // 视频大图
    lazy var videoImageButton = UIButton()
    
}
