//
//  WendaAnswerCell.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/4.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import IBAnimatable


class WendaAnswerCell: UITableViewCell, RegisterCellFromNib {
    
    /// 头像
    @IBOutlet weak var avatarImageView: AnimatableImageView!
    /// v
    @IBOutlet weak var vImageView: UIImageView!
    /// 用户名
    @IBOutlet weak var nameLabel: UILabel!
    /// 用户认证内容
    @IBOutlet weak var userIntroLabel: UILabel!
    @IBOutlet weak var userintroLabelHeight: NSLayoutConstraint!
    /// 关注按钮
    @IBOutlet weak var concernButton: UIButton!
    /// 点赞
    @IBOutlet weak var diggLabel: UILabel!
    /// 阅读
    @IBOutlet weak var readCountLabel: UILabel!
    /// 缩略图
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var thumbImageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var thumbImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var separatorView: UIView!
    /// 关注按钮点击
    @IBAction func concernButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected { // 关注用户
            NetworkTool.loadRelationFollow(userId: Int(answer.user.user_id)!, completionHandler: { _ in
                sender.theme_backgroundColor = "colors.userDetailFollowingConcernBtnBgColor"
            })
        } else { // 取消关注
            NetworkTool.loadRelationUnfollow(userId: Int(answer.user.user_id)!, completionHandler: { _ in
                sender.theme_backgroundColor = "colors.globalRedColor"
            })
        }
    }
    
    // 覆盖按钮点击
    @IBAction func coverButtonClicked(_ sender: UIButton) {
        didSelectCoverButton?()
    }
    
    // 覆盖按钮点击
    var didSelectCoverButton: (()->())?
    
    var answer = WendaAnswer() {
        didSet {
            nameLabel.text = answer.user.uname
            avatarImageView.kf.setImage(with: URL(string: answer.user.avatar_url))
            vImageView.isHidden = !answer.user.is_verify
            concernButton.isSelected = answer.user.is_following
            if answer.user.user_intro != "" {
                userIntroLabel.text = answer.user.user_intro
                userintroLabelHeight.constant = 16
            }
            diggLabel.text = answer.diggCount + "赞"
            readCountLabel.text = answer.browCount + "阅读"
            // 是否有图片
            if answer.content_abstract.hasImage {
                let thumb = answer.content_abstract.thumb_image_list.first!
                thumbImageView.kf.setImage(with: URL(string: thumb.urlString))
                thumbImageViewHeight.constant = 166
                thumbImageViewWidth.constant = 166 * thumb.ratio
            } else {
                thumbImageViewHeight.constant = 0
            }
            contentLabel.setSeparatedLinesFrom(attributedString: answer.attributedString, hasImage: answer.content_abstract.hasImage)
            contentLabelHeight.constant = answer.content_abstract.textH!
            layoutIfNeeded()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
        concernButton.theme_setTitleColor("colors.globalRedColor", forState: .normal)
        concernButton.theme_setTitleColor("colors.lightGray", forState: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
