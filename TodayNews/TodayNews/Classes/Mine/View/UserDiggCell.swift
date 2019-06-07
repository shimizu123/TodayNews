//
//  UserDiggCell.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/4/22.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import IBAnimatable

class UserDiggCell: UITableViewCell, RegisterCellFromNib {
    
    // 用户头像
    @IBOutlet weak var avatarImageView: AnimatableImageView!
    /// V 图标
    @IBOutlet weak var vImageView: UIImageView!
    /// 用户名
    @IBOutlet weak var nameLabel: UILabel!
    /// 认证内容
    @IBOutlet weak var verifiedContentLabel: UILabel!
    @IBOutlet weak var verifiedContentLabelHeight: NSLayoutConstraint!
    
    var user = DongtaiUserDigg() {
        didSet {
            avatarImageView.kf.setImage(with: URL(string: user.avatar_url))
            vImageView.isHidden = !user.user_verified
            nameLabel.text = user.screen_name
            verifiedContentLabel.text = user.verified_reason
            verifiedContentLabelHeight.constant = user.verified_reason != "" ? 20 : 0
            layoutIfNeeded()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        nameLabel.theme_textColor = "colors.black"
        verifiedContentLabel.theme_textColor = "colors.grayColor150"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
