//
//  WendaAnswerHeaderView.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/2.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class WendaAnswerHeaderView: UIView, NibLoadable {

    // 收藏问题按钮
    @IBOutlet weak var collectButton: UIButton!
    /// 邀请回答按钮
    @IBOutlet weak var inviteButton: UIButton!
    /// 分割线
    @IBOutlet weak var separatorView: UIView!
    
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabelHeight: NSLayoutConstraint!
    /// 内容
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentLabelHeight: NSLayoutConstraint!
    
    /// 回答数量
    @IBOutlet weak var answerCountLabel: UILabel!
    /// 收藏数量
    @IBOutlet weak var collectionCountLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    
    // 展开按钮
    @IBOutlet weak var unfoldButton: UIButton!
    @IBOutlet weak var unfoldButtonWidth: NSLayoutConstraint!
    /// 展开按钮点击
    @IBAction func unfoldButtonClicked(_ sender: UIButton) {
        sender.isHidden = true
        UIView.animate(withDuration: 0.25) {
            self.unfoldButtonWidth.constant = 0
            self.contentLabelHeight.constant = self.question.content.textH!
            self.layoutIfNeeded()
            self.didSelectUnfoldButton?()
        }
        self.height = question.unfoldHeight!
    }
    
    // 点击了展开按钮
    var didSelectUnfoldButton: (()->())?
    
    var question = WendaQuestion() {
        didSet {
            titleLabel.text = question.title
            titleLabelHeight.constant = question.titleH!
            contentLabel.text = question.content.text
            answerCountLabel.text = question.answerCount + "个回答 · "
            collectionCountLabel.text = question.followCount + "人收藏"
            // 如果有图
            if let thumb = question.content.thumb_image_list.first {
                imageView.kf.setImage(with: URL(string: thumb.urlString))
                imageViewHeight.constant = 166
                imageViewWidth.constant = 166 * thumb.ratio
            }
            self.height = question.foldHeight!
            layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        titleLabel.theme_textColor = "colors.black"
        contentLabel.theme_textColor = "colors.lightGray"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        collectButton.theme_setTitleColor("colors.userDetailSendMailTextColor", forState: .normal)
        inviteButton.theme_setTitleColor("colors.userDetailSendMailTextColor", forState: .normal)
        unfoldButton.theme_setTitleColor("colors.userDetailSendMailTextColor", forState: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.width = screenWidth
    }

}
