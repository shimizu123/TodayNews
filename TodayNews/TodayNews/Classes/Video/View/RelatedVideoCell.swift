//
//  RelatedVideoCell.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/31.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class RelatedVideoCell: UITableViewCell, RegisterCellFromNib {
    
    // 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 广告
    @IBOutlet weak var adLabel: UILabel!
    @IBOutlet weak var adLabelWidth: NSLayoutConstraint!
    /// 名称
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameLabelLeading: NSLayoutConstraint!
    /// 播放视频数量
    @IBOutlet weak var playCountLabel: UILabel!
    /// 缩略图
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var thumbImageViewWidth: NSLayoutConstraint!
    /// 时长
    @IBOutlet weak var timeLabel: UILabel!
    
    var relatedVideo = NewsModel() {
        didSet {
            titleLabel.text = relatedVideo.title
            nameLabel.text = relatedVideo.source
            thumbImageView.kf.setImage(with: URL(string: relatedVideo.middle_image.urlString))
            if relatedVideo.video_detail_info.video_watch_count != 0 {
                playCountLabel.text = relatedVideo.video_detail_info.videoWatchCount + "次播放"
            } else {
                playCountLabel.isHidden = true
            }
            timeLabel.text = relatedVideo.videoDuration
            timeLabel.isHidden = !relatedVideo.has_video
            switch relatedVideo.card_type {
            case .video: // 视频
                adLabelWidth.constant = 0
                nameLabelLeading.constant = 0
            case .adVideo: // 广告视频
                adLabelWidth.constant = 32
                nameLabelLeading.constant = 5
            case .adTextlink: // 广告链接
                thumbImageViewWidth.constant = thumbImageView.superview!.width
                timeLabel.isHidden = true
                playCountLabel.isHidden = true
                adLabelWidth.constant = 32
                nameLabelLeading.constant = 5
            }
            layoutIfNeeded()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        titleLabel.theme_textColor = "colors.black"
        nameLabel.theme_textColor = "colors.grayColor150"
        playCountLabel.theme_textColor = "colors.grayColor150"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
