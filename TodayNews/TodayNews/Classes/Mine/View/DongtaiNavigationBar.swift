//
//  DongtaiNavigationBar.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/4/18.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import IBAnimatable

class DongtaiNavigationBar: UIView, NibLoadable {

    // 头像
    @IBOutlet weak var avatarButton: AnimatableButton!
    ///  v 图标
    @IBOutlet weak var vImageView: UIImageView!
    /// 用户名
    @IBOutlet weak var nameButton: UIButton!
    /// 粉丝数量
    @IBOutlet weak var followersButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func buttonClicked() {
        
    }
    
    var user = DongtaiUser() {
        didSet {
            avatarButton.kf.setImage(with: URL(string: user.avatar_url), for: .normal)
            nameButton.setTitle(user.screen_name, for: .normal)
            followersButton.setTitle(user.followersCount + "粉丝", for: .normal)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameButton.theme_setTitleColor("colors.black", forState: .normal)
        followersButton.theme_setTitleColor("colors.black", forState: .normal)
    }
    
    // 固有的大小
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }
    
}
