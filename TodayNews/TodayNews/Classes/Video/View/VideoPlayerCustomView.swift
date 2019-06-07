//
//  VideoPlayerCustomView.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/16.
//  Copyright © 2019 邓康大. All rights reserved.
//

import BMPlayer

class VideoPlayerCustomView: BMPlayerControlView {
    
    override func customizeUIComponents() {
        BMPlayerConf.topBarShowInCase = .none
    }
    
}
