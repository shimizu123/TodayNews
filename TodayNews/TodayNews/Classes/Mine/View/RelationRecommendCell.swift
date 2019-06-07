//
//  RelationRecommendCell.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/3/19.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import IBAnimatable

class RelationRecommendCell: UICollectionViewCell, RegisterCellFromNib {
    
    /// 头像
    @IBOutlet weak var avatarImageView: AnimatableImageView!
    /// V 图标
    @IBOutlet weak var vImageView: UIImageView!
    /// 用户名称
    @IBOutlet weak var nameLabel: UILabel!
    /// 推荐原因
    @IBOutlet weak var recommendReasonLabel: UILabel!
    /// 加载 图标
    @IBOutlet weak var loadingImageView: UIImageView!
    /// 关注按钮
    @IBOutlet weak var concernButton: AnimatableButton!
    
    @IBOutlet weak var baseView: AnimatableView!
    
    var userCard = UserCard() {
        didSet {
            nameLabel.text = userCard.user.info.name
            avatarImageView.kf.setImage(with: URL(string: userCard.user.info.avatar_url))
            vImageView.isHidden = userCard.user.info.user_auth_info.auth_info == ""
            recommendReasonLabel.text = userCard.recommend_reason
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        nameLabel.theme_textColor = "colors.black"
        recommendReasonLabel.theme_textColor = "colors.black"
        baseView.theme_backgroundColor = "colors.cellBackgroundColor"
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonTextColor", forState: .normal)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonSelectedTextColor", forState: .selected)
        
    }
    
    // 关注按钮点击
    @IBAction func concernButtonClicked(_ sender: AnimatableButton) {
        sender.isSelected = !sender.isSelected
        loadingImageView.isHidden = false
        loadingImageView.layer.add(animation, forKey: nil)
        if sender.isSelected { // 已经关注
            NetworkTool.loadRelationFollow(userId: userCard.user.info.user_id, completionHandler: { _ in
                sender.theme_backgroundColor = "colors.userDetailFollowingConcernBtnBgColor"
                self.loadingImageView.layer.removeAllAnimations()
                self.loadingImageView.isHidden = true
                sender.borderColor = UIColor.grayColor232()
                sender.borderWidth = 1
            })
        } else { // 未关注
            NetworkTool.loadRelationUnfollow(userId: userCard.user.info.user_id, completionHandler: { _ in
                sender.theme_backgroundColor = "colors.globalRedColor"
                self.loadingImageView.layer.removeAllAnimations()
                self.loadingImageView.isHidden = true
                sender.borderWidth = 0
            })
        }
        
        
    }
    
    private lazy var animation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 1.5
        animation.autoreverses = false
        animation.repeatCount = MAXFLOAT
        return animation
    }()
    

}
