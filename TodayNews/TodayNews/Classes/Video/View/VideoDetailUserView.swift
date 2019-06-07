//
//  VideoDetailUserView.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/31.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import IBAnimatable

class VideoDetailUserView: UIView, NibLoadable {
    
    // 覆盖按钮
    @IBOutlet weak var coverButton: UIButton!
    /// 头像
    @IBOutlet weak var avatarImageView: UIImageView!
    /// v
    @IBOutlet weak var vImageView: UIImageView!
    /// 用户名
    @IBOutlet weak var nameLabel: UILabel!
    /// 粉丝数量
    @IBOutlet weak var followerCountLabel: UILabel!
    /// 关注按钮点击
    @IBOutlet weak var concernButton: AnimatableButton!

    var userInfo = NewsUserInfo() {
        didSet {
            avatarImageView.kf.setImage(with: URL(string: userInfo.avatar_url))
            vImageView.isHidden = !userInfo.user_verified
            nameLabel.text = userInfo.name
            followerCountLabel.text = userInfo.fansCount + "粉丝"
            concernButton.isSelected = userInfo.follow
            concernButton.theme_backgroundColor = userInfo.follow ? "colors.userDetailFollowingConcernBtnBgColor" : "colors.globalRedColor"
            concernButton.borderColor = userInfo.follow ? UIColor.grayColor232() : UIColor.globalRedColor()
            concernButton.borderWidth = userInfo.follow ? 1 : 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        nameLabel.theme_textColor = "colors.black"
        followerCountLabel.theme_textColor = "colors.black"
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonTextColor", forState: .normal)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonSelectedTextColor", forState: .selected)
    }
    
    // 关注按钮点击
    @IBAction func concernButtonClicked(_ sender: AnimatableButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected { // 已经关注
            NetworkTool.loadRelationFollow(userId: userInfo.user_id, completionHandler: { _ in
                sender.theme_backgroundColor = "colors.userDetailFollowingConcernBtnBgColor"
                sender.borderColor = UIColor.grayColor232()
                sender.borderWidth = 1
            })
        } else { // 未关注
            NetworkTool.loadRelationUnfollow(userId: userInfo.user_id, completionHandler: { _ in
                sender.theme_backgroundColor = "colors.globalRedColor"
                sender.borderWidth = 0
            })
        }
    }

}
