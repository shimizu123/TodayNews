//
//  MyOtherCell.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/3/7.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class MyOtherCell: UITableViewCell, RegisterCellFromNib {
    
    // 标题
    @IBOutlet weak var leftLabel: UILabel!
    // 副标题
    @IBOutlet weak var rightLabel: UILabel!
    // 右边箭头
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var separatorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置主题
        theme_backgroundColor = "colors.cellBackgroundColor"
        leftLabel.theme_textColor = "colors.black"
        rightLabel.theme_textColor = "colors.cellRightTextColor"
        rightImageView.theme_image = "images.cellRightArrow"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
