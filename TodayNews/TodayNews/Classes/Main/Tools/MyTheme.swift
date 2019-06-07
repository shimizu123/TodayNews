//
//  MyTheme.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/3/7.
//  Copyright © 2019 邓康大. All rights reserved.
//

import Foundation
import SwiftTheme

enum MyTheme: Int {
    case day = 0
    case night = 1
    
    static var before = MyTheme.day
    static var current = MyTheme.day
    
    
    // 选择主题
    static func switchTo(theme: MyTheme) {
        before = current
        current = theme
        
        switch theme {
        case .day:
            ThemeManager.setTheme(plistName: "default_theme", path: .mainBundle)
        case .night:
            ThemeManager.setTheme(plistName: "night_theme", path: .mainBundle)
        }
    }
    
    // 选择了夜间主题
    static func switchNight(isToNight: Bool) {
            switchTo(theme: isToNight ? .night : .day)
    }
        
    
    // 判断当前是否是夜间主题
    static func isNight() -> Bool {
        return current == .night
    }
    
}

struct MyThemeStyle {
    // 设置导航栏样式 （日间、夜间）
    static func setupNavigationBarStyle(viewController: UIViewController, isNight: Bool) {
        
        if isNight { // 设置夜间主题
            viewController.navigationController?.navigationBar.barStyle = .black
            viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background_white_night"), for: .default)
            viewController.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.grayColor113()]
        } else {    // 设置日间主题
            viewController.navigationController?.navigationBar.barStyle = .default
            viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_background_white"), for: .default)
        }
        
        
    }
}













