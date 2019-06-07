//
//  HomeUserCell.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/18.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class HomeUserCell: UITableViewCell, RegisterCellFromNib {
    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var vipImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var verifiedContentLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var readCountLabel: UILabel!
    @IBOutlet weak var concernButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var digButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var feedshareButton: UIButton!
    
    var aNews = NewsModel() {
        didSet {
            // 发布者
            if aNews.source != "" {
                nameLabel.text = aNews.source
            } else if aNews.user.user_id != 0 {
                avatarImageView.kf.setImage(with: URL(string: aNews.user.avatar_url))
                nameLabel.text = aNews.user.screen_name
            } else if aNews.user_info.user_id != 0 {
                avatarImageView.kf.setImage(with: URL(string: aNews.user_info.avatar_url))
                nameLabel.text = aNews.user_info.name
            } else if aNews.media_info.user_id != 0 {
                avatarImageView.kf.setImage(with: URL(string: aNews.media_info.avatar_url))
                nameLabel.text = aNews.media_info.name
            }
            readCountLabel.text = "\(aNews.readCount)阅读"
            verifiedContentLabel.text = aNews.verified_content
            digButton.setTitle(aNews.diggCount, for: .normal)
            commentButton.setTitle(aNews.commentCount, for: .normal)
            feedshareButton.setTitle(aNews.shareCount, for: .normal)
            contentLabel.attributedText = aNews.attributedContent
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        closeButton.theme_setImage("images.add_textpage_17x12_", forState: .normal)
        nameLabel.theme_textColor = "colors.black"
        verifiedContentLabel.theme_textColor = "colors.cellRightTextColor"
        readCountLabel.theme_textColor = "colors.cellRightTextColor"
        self.contentView.theme_backgroundColor = "colors.cellBackgroundColor"
        digButton.theme_setImage("images.like_old_feed_24x24_", forState: .normal)
        digButton.theme_setImage("images.like_old_feed_press_24x24_", forState: .selected)
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        commentButton.theme_setImage("images.comment_24x24_", forState: .normal)
        feedshareButton.theme_setImage("images.feed_share_24x24_", forState: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
