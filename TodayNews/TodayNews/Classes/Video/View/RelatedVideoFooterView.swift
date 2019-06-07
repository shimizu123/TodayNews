//
//  RelatedVideoFooterView.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/6/1.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import IBAnimatable

class RelatedVideoFooterView: UIView, NibLoadable {
    
    // 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 查看更多
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var moreButtonHeight: NSLayoutConstraint!
    /// 缩略图
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var thumbAspect: NSLayoutConstraint!
    /// app 名称
    @IBOutlet weak var nameLabel: UILabel!
    /// 立即下载
    @IBOutlet weak var downloadButton: AnimatableButton!
    
    @IBOutlet weak var separatorView: UIView!
    
    @IBOutlet weak var bgView: UIView!

    var ad = AD() {
        didSet {
            if ad.app.ad_id != 0 {
                titleLabel.text = ad.app.title
                nameLabel.text = ad.app.app_name
                downloadButton.setTitle(ad.app.button_text, for: .normal)
                if let urlList = ad.app.image.url_list.first {
                    thumbImageView.kf.setImage(with: URL(string: urlList.url))
                }
            } else if ad.mixed.id != 0 {
                titleLabel.text = ad.mixed.title
                nameLabel.text = ad.mixed.source_name
                if ad.mixed.image != "" {
                    thumbImageView.kf.setImage(with: URL(string: ad.mixed.image))
                } else if let image = ad.mixed.image_list.first {
                    if let urlList = image.url_list.first {
                        thumbImageView.kf.setImage(with: URL(string: urlList.url))
                    }
                }
                downloadButton.setTitle(ad.mixed.button_text, for: .normal)
            } else { // 没有广告
                bgView.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.separatorViewColor"
        bgView.theme_backgroundColor = "colors.cellBackgroundColor"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        moreButton.theme_setImage("images.arrow_down_16_16x14_", forState: .normal)
        titleLabel.theme_textColor = "colors.black"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.width = screenWidth
        // 没有广告
        if ad.app.ad_id == 0 && ad.mixed.id == 0 {
            self.height = moreButton.isSelected ? 0 : 40
        } else {
            self.height = bgView.frame.maxY
        }
    }
    
    // 查看更多点击
    @IBAction func moreButtonClicked(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25) {
            self.moreButtonHeight.constant = 0
            self.layoutIfNeeded()
        }
      //  self.height = 300
    }
    
    // 关闭按钮点击
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        
    }

}
