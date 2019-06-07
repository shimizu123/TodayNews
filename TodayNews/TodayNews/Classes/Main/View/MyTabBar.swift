//
//  MyTabBar.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/2/26.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class MyTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        theme_tintColor = "colors.tabbarTintColor"
        theme_barTintColor = "colors.cellBackgroundColor"
        self.addSubview(publishButton)
    }
    
    // private 绝对私有，除了在当前类中可以访问之外，其他任何类或该类的扩展都不能访问到
    // fileprivate 文件私有，可以在当前类文件中访问，其他文件不能访问
    // open 在任何类文件中都能访问
    // internal 默认，也可以不写
    private lazy var publishButton: UIButton = {
        let publishButton = UIButton(type: .custom)
        publishButton.setBackgroundImage(UIImage(named: "feed_publish_44x44_"), for: .normal)
        publishButton.setBackgroundImage(UIImage(named: "feed_publish_press_44x44_"), for: .selected)
        publishButton.sizeToFit()
        return publishButton
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let width = self.frame.width
        let height: CGFloat = 49
        
        publishButton.center = CGPoint(x: width / 2, y: height / 2 - 7)
        
        let buttonW: CGFloat = width / 5
        let buttonH: CGFloat = height
        let buttonY: CGFloat = 0
        
        var index = 0
        
        for button in self.subviews {
            if !button.isKind(of: NSClassFromString("UITabBarButton")!) {
                continue
            }
            let buttonX = buttonW * (index > 1 ? CGFloat(index + 1) : CGFloat(index))
            
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
            
            index += 1
            
        }
    }
    
}
