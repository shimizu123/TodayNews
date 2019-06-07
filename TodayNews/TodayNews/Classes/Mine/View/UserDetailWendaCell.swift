//
//  UserDetailWendaCell.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/4/17.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class UserDetailWendaCell: UITableViewCell, RegisterCellFromNib {
    
    /// 问题的标题
    @IBOutlet weak var questionTitleLabel: UILabel!
    /// 回答的内容
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentLabelHeight: NSLayoutConstraint!
    /// 点赞数量
    @IBOutlet weak var diggCountLabel: UILabel!
    /// 阅读数量
    @IBOutlet weak var readCountLabel: UILabel!
    /// 显示时间
    @IBOutlet weak var showTimeLabel: UILabel!
    
    var wenda = UserDetailWenda() {
        didSet {
            questionTitleLabel.text = wenda.question.title
            contentLabel.text = wenda.answer.content_abstract.text
            diggCountLabel.text = wenda.answer.diggCount + "赞 ·"
            readCountLabel.text = wenda.answer.browCount + "人阅读"
            showTimeLabel.text = wenda.answer.show_time
            contentLabelHeight.constant = wenda.answer.content_abstract.textHeight
            layoutIfNeeded()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
