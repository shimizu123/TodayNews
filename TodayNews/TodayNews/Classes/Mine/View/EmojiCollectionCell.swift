//
//  EmojiCollectionCell.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/4/24.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class EmojiCollectionCell: UICollectionViewCell, RegisterCellFromNib {
    
    @IBOutlet weak var iconButton: UIButton!
    
    var emoji = Emoji() {
        didSet {
            if emoji.isDelete { // 是删除按钮
                iconButton.theme_setImage("images.input_emoji_delete_44x44_", forState: .normal)
            } else if emoji.isEmpty { // 如果是空表情
                iconButton.setImage(nil, for: .normal)
            } else {
                iconButton.setImage(UIImage(named: emoji.png), for: .normal)
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
    }

}
