//
//  SVProgressHUD+Extension.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/4/6.
//  Copyright © 2019 邓康大. All rights reserved.
//

import SVProgressHUD

extension SVProgressHUD {
    // 设置 SVProgressHUD 属性
    class func configuration() {
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.3))
    }
}
