//
//  OfflineSectionHeader.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/3/12.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class OfflineSectionHeader: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        theme_backgroundColor = "colors.tableViewBackgroundColor"
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: screenWidth, height: self.height))
        label.text = "我的频道"
        label.theme_textColor = "colors.black"
        let separatorView = UIView(frame: CGRect(x: 0, y: self.height - 1, width: screenWidth, height: 1))
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        self.addSubview(label)
        self.addSubview(separatorView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
