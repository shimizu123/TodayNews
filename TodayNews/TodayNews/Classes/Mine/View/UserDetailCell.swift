//
//  UserDetailCell.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/3/22.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class UserDetailCell: UITableViewCell, RegisterCellFromNib {
    
    @IBOutlet weak var scrollView: UIScrollView!

    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
