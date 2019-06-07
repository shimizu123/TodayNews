//
//  Constant.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/2/27.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

//屏幕宽高
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
// emoji 宽度
let emojiItemWidth = screenWidth / 7


/// 服务器地址
//let BASE_URL = "http://lf.snssdk.com"
//let BASE_URL = "http://ib.snssdk.com"
let BASE_URL = "https://is.snssdk.com"

let device_id: Int = 6096495334
let iid: Int = 5034850950

let isIphoneX: Bool = screenHeight == 812 ? true : false

let newsTitleHeight: CGFloat = 40
let kMyHeaderViewHeight: CGFloat = 280
let kUserDetailHeaderBGImageViewHeight: CGFloat = 146

let isNight = "isNight"

let MyPresentationControllerDismiss = "MyPresentationControllerDismiss"
let NavigationBarConcernButtonClicked = "NavigationBarConcernButtonClicked"
let UserDetailHeaderViewButtonClicked = "UserDetailHeaderViewButtonClicked"

// 关注的用户详情界面 topTab 的按钮的宽度
let topTabButtonWidth: CGFloat = screenWidth / 5
// 关注的用户详情界面 topTab 的指示条的宽度 和 高度
let topTabIndicatorWidth: CGFloat = 40
let topTabIndicatorHeight: CGFloat = 2

// 动态图片的宽高
// 图片的宽高
// 1        screenWidth * 0.5
// 2        (screenWidth - 35) / 2
// 3,4,5-9    (screenWidth - 40) / 3
let image1Width: CGFloat = screenWidth / 2
let image2Width: CGFloat = (screenWidth - 35) / 2
let image3Width: CGFloat = (screenWidth - 40) / 3

// 从哪里进入问答控制器
enum WendaEnterFrom: String {
    case dongtai = "dongtai"
    case clickHeadline = "click_headline"
    case clickCategory = "click_category"
}

// 从哪里进入头条
enum TTFrom: String {
    case pull = "pull"
    case loadMore = "load_more"
    case auto = "auto"
    case enterAuto = "enter_auto"
    case preLoadMoreDraw = "pre_load_more_draw"
}


