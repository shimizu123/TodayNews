//
//  UserDetailHeaderView.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/3/13.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import IBAnimatable

class UserDetailHeaderView: UIView, NibLoadable {

    // 点击了关注按钮
    var didSelectConcernButton: (()->())?
    // 点击了用户名
    var didSelectUserName: ((_ uid: Int)->())?
    
    var userDetail = UserDetail() {
        didSet {
            backgroundImageView.kf.setImage(with: URL(string: userDetail.bg_img_url))
            avatarImageView.kf.setImage(with: URL(string: userDetail.avatar_url))
            vImageView.isHidden = !userDetail.user_verified
            nameLabel.text = userDetail.screen_name
            if userDetail.verified_agency == "" {
                verifiedAgencyLabelHeight.constant = 0
                verifiedAgencyLabelTop.constant = 0
            } else {
                verifiedAgencyLabel.text = userDetail.verified_agency + "："
                verifiedContentLabel.text = userDetail.verified_content
            }
            concernButton.isSelected = userDetail.is_following
            concernButton.theme_backgroundColor = userDetail.is_following ? "colors.userDetailFollowingConcernBtnBgColor" : "colors.globalRedColor"
            concernButton.borderColor = userDetail.is_following ? UIColor.grayColor232() : UIColor.globalRedColor()
            concernButton.borderWidth = userDetail.is_following ? 1 : 0
            if userDetail.area != "" {
                areaButtonHeight.constant = 20
                areaButtonTop.constant = 10
                areaButton.setTitle(userDetail.area, for: .normal)
            }
            descriptionLabel.attributedText = userDetail.attributedDescription
            if userDetail.descriptionHeight > 21 {
                unfoldButton.isHidden = false
                unfoldButtonWidth.constant = 40
            }
            // 推荐按钮的约束
            recommendButtonWidth.constant = 0
            recommendButtonTrailing.constant = 10
            
            followingsCountLabel.text = userDetail.followingsCount
            followersCountLabel.text = userDetail.followersCount
            //刷新约束（更新UI）
            layoutIfNeeded()
        }
    }
    
    /// 背景图片
    @IBOutlet weak var backgroundImageView: UIImageView!
    /// 背景图片顶部约束
    @IBOutlet weak var bgImageViewTop: NSLayoutConstraint!
    /// 用户头像
    @IBOutlet weak var avatarImageView: UIImageView!
    /// V 图标
    @IBOutlet weak var vImageView: UIImageView!
    /// 用户名
    @IBOutlet weak var nameLabel: UILabel!
    /// 头条号图标
    @IBOutlet weak var toutiaohaoImageView: UIImageView!
    /// 发私信按钮
    @IBOutlet weak var sendMailButton: UIButton!
    /// 关注按钮
    @IBOutlet weak var concernButton: AnimatableButton!
    /// 推荐按钮
    @IBOutlet weak var recommendButton: AnimatableButton!
    @IBOutlet weak var recommendButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var recommendButtonTrailing: NSLayoutConstraint!
    /// 推荐 view
    @IBOutlet weak var recommendView: UIView!
    @IBOutlet weak var recommendViewHeight: NSLayoutConstraint!
    /// 头条认证
    @IBOutlet weak var verifiedAgencyLabel: UILabel!
    @IBOutlet weak var verifiedAgencyLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var verifiedAgencyLabelTop: NSLayoutConstraint!
    /// 认证内容
    @IBOutlet weak var verifiedContentLabel: UILabel!
    /// 地区
    @IBOutlet weak var areaButton: UIButton!
    @IBOutlet weak var areaButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var areaButtonTop: NSLayoutConstraint!
    /// 描述内容
    @IBOutlet weak var descriptionLabel: RichLabel!
    @IBOutlet weak var descriptionLabelHeight: NSLayoutConstraint!
    /// 展开按钮
    @IBOutlet weak var unfoldButton: UIButton!
    @IBOutlet weak var unfoldButtonTrailing: NSLayoutConstraint!
    @IBOutlet weak var unfoldButtonWidth: NSLayoutConstraint!
    /// 关注数量
    @IBOutlet weak var followingsCountLabel: UILabel!
    /// 粉丝数量
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    /// 底层 view
    @IBOutlet weak var baseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置图片顶部约束
        bgImageViewTop.constant = isIphoneX ? -88 : -64
        layoutIfNeeded()
        concernButton.setTitle("关注", for: .normal)
        concernButton.setTitle("已关注", for: .selected)
        // 设置主题颜色
        theme_backgroundColor = "colors.cellBackgroundColor"
        baseView.theme_backgroundColor = "colors.cellBackgroundColor"
        avatarImageView.layer.theme_borderColor = "colors.cellBackgroundColor"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        nameLabel.theme_textColor = "colors.black"
        sendMailButton.theme_setTitleColor("colors.userDetailSendMailTextColor", forState: .normal)
        unfoldButton.theme_setTitleColor("colors.userDetailSendMailTextColor", forState: .normal)
        followingsCountLabel.theme_textColor = "colors.userDetailSendMailTextColor"
        followersCountLabel.theme_textColor = "colors.userDetailSendMailTextColor"
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonTextColor", forState: .normal)
        concernButton.theme_setTitleColor("colors.userDetailConcernButtonSelectedTextColor", forState: .selected)
        verifiedAgencyLabel.theme_textColor = "colors.verifiedAgencyTextColor"
        verifiedContentLabel.theme_textColor = "colors.black"
        descriptionLabel.theme_textColor = "colors.black"
        toutiaohaoImageView.theme_image = "images.toutiaohao"
        areaButton.theme_setTitleColor("colors.black", forState: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(receivedConcernButtonClicked), name: NSNotification.Name(rawValue: NavigationBarConcernButtonClicked), object: nil)
    }
    
    // 自定义的推荐 view
    fileprivate lazy var relationRecommendView: RelationRecommendView = {
        let relationRecommendView = RelationRecommendView.loadViewFromNib()
        return relationRecommendView
    }()
    
   
    
    // 接收到了关注按钮的点击
    @objc func receivedConcernButtonClicked(notification: Notification) {
        let userInfo = notification.userInfo as! [String: Any]
        let isSelected = userInfo["isSelected"] as! Bool
        concernButton.isSelected = isSelected
        concernButton.theme_backgroundColor = isSelected ? "colors.userDetailFollowingConcernBtnBgColor" : "colors.globalRedColor"
        concernButton.borderColor = isSelected ? UIColor.grayColor232() : UIColor.globalRedColor()
        concernButton.borderWidth = isSelected ? 1 : 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 点击事件
    
    // 头像按钮点击
    @IBAction func avatarButtonClicked(_ sender: UIButton) {
        let previewUserAvatarVC = PreviewUserAvatarController()
        previewUserAvatarVC.avatar_url = userDetail.big_avatar_url
        UIApplication.shared.keyWindow?.rootViewController?.present(previewUserAvatarVC, animated: false, completion: nil)
    }
    
    // 发私信按钮点击
    @IBAction func sendMailButtonClicked(_ sender: UIButton) {
        let moreLoginVC = MoreLoginViewController.loadStoryboard()
        moreLoginVC.modalSize = (width: .full, height: .custom(size: Float(screenHeight - (isIphoneX ? 44 : 20))))
        UIApplication.shared.keyWindow?.rootViewController?.present(moreLoginVC, animated: true, completion: nil)
    }
    
    // 关注按钮点击
    @IBAction func concernButtonClicked(_ sender: AnimatableButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected { // 已经关注
            NetworkTool.loadRelationFollow(userId: userDetail.user_id, completionHandler: { _ in
                sender.theme_backgroundColor = "colors.userDetailFollowingConcernBtnBgColor"
                sender.borderColor = UIColor.grayColor232()
                sender.borderWidth = 1
                self.recommendButton.isHidden = false
                self.recommendButton.isSelected = false
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.recommendButtonWidth.constant = 28
                    self.recommendButtonTrailing.constant = 15
                    self.recommendViewHeight.constant = 233
                    self.layoutIfNeeded()
                    self.didSelectConcernButton?()
                }, completion: { _ in
                    // 点击了关注按钮，就会出现相关推荐数据
                    NetworkTool.loadRelationUserRecommend(userId: self.userDetail.user_id, completionHandler: { (userCards) in
                        self.relationRecommendView.userCards = userCards
                        self.recommendView.addSubview(self.relationRecommendView)
                    })
                })
            })
        } else { // 未关注
            NetworkTool.loadRelationUnfollow(userId: userDetail.user_id, completionHandler: { _ in
                sender.theme_backgroundColor = "colors.globalRedColor"
                self.recommendButton.isHidden = true
                self.recommendButton.isSelected = false
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.recommendButtonWidth.constant = 0
                    self.recommendButtonTrailing.constant = 0
                    self.recommendViewHeight.constant = 0
                    self.recommendButton.imageView?.transform = .identity
                    self.layoutIfNeeded()
                    self.didSelectConcernButton?()
                })
            })
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UserDetailHeaderViewButtonClicked), object: self, userInfo: ["isSelected": sender.isSelected])
    }
    
    // 推荐关注按钮点击
    @IBAction func recommendButtonClicked(_ sender: AnimatableButton) {
        sender.isSelected = !sender.isSelected
        relationRecommendView.labelHeight.constant = sender.isSelected ? 0 : 32
        recommendViewHeight.constant = sender.isSelected ? 0 : 233
        
        UIView.animate(withDuration: 0.25) {
            sender.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(sender.isSelected ? Double.pi : 0))
            self.layoutIfNeeded()
            self.relationRecommendView.layoutIfNeeded()
            self.didSelectConcernButton?()
        }
    }
    
    // 展开按钮点击
    @IBAction func unfoldButtonClicked() {
        unfoldButton.isHidden = true
        self.unfoldButtonWidth.constant = 0
        
        UIView.animate(withDuration: 0.25) {
            self.relationRecommendView.labelHeight.constant = 0
            self.relationRecommendView.layoutIfNeeded()
            self.descriptionLabelHeight.constant = self.userDetail.descriptionHeight
            self.layoutIfNeeded()
            self.didSelectConcernButton?()
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.height = baseView.frame.maxY
    }
    
}


