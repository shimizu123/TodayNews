//
//  PostVideoOrArticleView.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/4/15.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class PostVideoOrArticleView: UIView, NibLoadable {

    // 图标
    @IBOutlet weak var iconButton: UIButton!
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconButtonWidth: NSLayoutConstraint!
    
    /// 覆盖按钮点击
    @IBAction func coverButtonClicked(_ sender: UIButton) {
        
    }
    
    // 原内容是否已经删除
    var delete = false {
        didSet {
            originThreadHasDeleted()
        }
    }
    
    var group = DongtaiOriginGroup() {
        didSet {
            titleLabel.text = " " + group.title
            if group.thumb_url != "" {
                iconButton.kf.setImage(with: URL(string: group.thumb_url), for: .normal)
            } else if group.user.avatar_url != "" {
                iconButton.kf.setImage(with: URL(string: group.user.avatar_url), for: .normal)
            } else if group.delete {
                originThreadHasDeleted()
            }
            
            switch group.media_type {
            case .postArticle:
                iconButton.setImage(nil, for: .normal)
            case .postVideo:
                iconButton.theme_setImage("images.smallvideo_all_32x32_", forState: .normal)
            }
        }
    }
    
    
    // 原内容已经删除
    func originThreadHasDeleted() {
        titleLabel.text = "原内容已经删除"
        titleLabel.textAlignment = .center
        iconButtonWidth.constant = 0
        layoutIfNeeded()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        titleLabel.theme_textColor = "colors.black"
        titleLabel.theme_backgroundColor = "colors.grayColor247"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.width = screenWidth - 30
    }

}
