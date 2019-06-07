//
//  WendaAnswerBottomView.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/1.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class WendaAnswerBottomView: UIView {

    let buttonWidth = screenWidth * 0.3
    
    let currentTheme = UserDefaults.standard.bool(forKey: isNight)
    
    var modules = [WendaModule]() {
        didSet {
            for (index, module) in modules.enumerated() {
                let button = BottomButton(frame: CGRect(x: CGFloat(index) * buttonWidth, y: 0, width: buttonWidth, height: 40))
                button.setTitle(module.text, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                button.theme_setTitleColor("colors.black", forState: .normal)
                button.kf.setImage(with: URL(string: currentTheme ? module.night_icon_url : module.day_icon_url), for: .normal)
                self.addSubview(button)
            }
        }
    }
    
}

class BottomButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = CGRect(x: 15, y: 9, width: 22, height: 22)
    }
}
