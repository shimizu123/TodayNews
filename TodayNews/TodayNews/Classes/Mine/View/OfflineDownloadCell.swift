//
//  OfflineDownloadCell.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/3/11.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class OfflineDownloadCell: UITableViewCell, RegisterCellFromNib {
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 勾选图片
    @IBOutlet weak var rightImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        titleLabel.theme_textColor = "colors.black"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
