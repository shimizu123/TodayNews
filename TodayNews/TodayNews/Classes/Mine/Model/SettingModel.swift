//
//  SettingModel.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/3/9.
//  Copyright © 2019 邓康大. All rights reserved.
//

import Foundation
import HandyJSON

struct SettingModel: HandyJSON {
    
    var title: String = ""
    var subtitle: String = ""
    var rightTitle: String = ""
    var isHiddenSubtitle: Bool = false
    var isHiddenRightTitle: Bool = false
    var isHiddenSwitch: Bool = false
    var isHiddenRightArrow: Bool = false
    
}
