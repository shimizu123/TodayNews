//
//  HomeNavigationView.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/9.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import IBAnimatable

class HomeNavigationView: UIView, NibLoadable {

    @IBOutlet weak var searchButton: AnimatableButton!
    
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    // 搜索按钮点击
    var didSelectSearchButton: (()->())?
    // 头像按钮点击
    var didSelectAvatarButton: (()->())?
    // 相机按钮点击
    var didSelectCameraButton: (()->())?
    
    // 相机按钮点击
    @IBAction func cameraButtonClicked(_ sender: UIButton) {
       didSelectCameraButton?()
    }
    /// 头像按钮点击
    @IBAction func avatarButtonClicked(_ sender: UIButton) {
       didSelectAvatarButton?()
    }
    
    /// 搜索按钮点击
    @IBAction func searchButtonClicked(_ sender: AnimatableButton) {
        didSelectSearchButton?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchButton.theme_backgroundColor = "colors.cellBackgroundColor"
        searchButton.theme_setTitleColor("colors.grayColor150", forState: .normal)
        searchButton.setImage(UIImage(named: "search_small_16x16_"), for: [.normal, .highlighted])
        cameraButton.theme_setImage("images.home_camera", forState: .normal)
        cameraButton.theme_setImage("images.home_camera", forState: .highlighted)
        avatarButton.theme_setImage("images.home_no_login_head", forState: .normal)
        avatarButton.theme_setImage("images.home_no_login_head", forState: .highlighted)
        // 首页顶部导航栏搜索推荐标题内容
        NetworkTool.loadHomeSearchSuggestInfo {
            self.searchButton.setTitle($0, for: .normal)
        }
    }
    
    // 固有的大小
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }
    
    // 重写 frame
    override var frame: CGRect {
        didSet {
            super.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
        }
    }

}
