//
//  MineViewController.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/2/26.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import SwiftTheme
import RxSwift
import IBAnimatable

class MineViewController: UITableViewController {
    
    private let disposeBag = DisposeBag()
    // 存储 cell的数据
    var sections = [[MyCellModel]]()
    
    // 存储我的关注数据
    var concerns = [MyConcern]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headerView
        tableView.separatorStyle = .none
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        tableView.ym_registerCell(cell: MyFirstSectionCell.self)
        tableView.ym_registerCell(cell: MyOtherCell.self)
        // 获取我的 cell 的数据
        NetworkTool.loadMyCellData {
            self.sections = $0 //第1个参数
            self.tableView.reloadData()
            // 我的关注数据
            NetworkTool.loadMyConcern(completionHandler: {
                self.concerns = $0
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            })           
        }
        // 更多按钮点击
        headerView.moreLoginButtonClicked = { [weak self] in
            let moreLoginVC = MoreLoginViewController.loadStoryboard()
            moreLoginVC.modalSize = (width: .full, height: .custom(size: Float(screenHeight - (isIphoneX ? 44 : 20))))
            self?.present(moreLoginVC, animated: true, completion: nil)
            
        }
        
    }
    
    // 懒加载 头部
    private lazy var headerView = LoginHeaderView.loadViewFromNib()

   
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    

}

// MARK: - UITableViewDelegate, UITableViewDataSource代理方法
extension MineViewController {
    
    // 每组头部的高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 0 : 10
    }
    
    // 每组头部视图
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return (concerns.count == 0 || concerns.count == 1) ? 40 : 114
        }
        return 40
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as MyFirstSectionCell
            cell.myCellModel = sections[indexPath.section][indexPath.row]
            cell.collectionView.isHidden = (sections.count == 0 || sections.count == 1)
            if concerns.count == 1 {cell.myConcern = concerns[0]}
            if concerns.count > 1 {cell.myConcerns = concerns}
            //点击了关注用户
            cell.myConcernSelected = {
                let userDetailVC = UserDetailViewController()
                userDetailVC.userId = $0.userid
                self.navigationController?.pushViewController(userDetailVC, animated: true)
            }
            
            return cell
        }
        
        let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as MyOtherCell
        let myCellModel = sections[indexPath.section][indexPath.row]
        cell.leftLabel.text = myCellModel.text
        cell.rightLabel.text = myCellModel.grey_text
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //取消侧cell选中效果
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 3 && indexPath.row == 1 { // 跳转到系统设置界面
            let settingVC = SettingViewController()
            navigationController?.pushViewController(settingVC, animated: true)
            
        }
        
        
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            let totalOffset = kMyHeaderViewHeight + abs(offsetY)
            let f = totalOffset / kMyHeaderViewHeight
            headerView.bgImageView.frame = CGRect(x: -screenWidth * (f - 1) / 2, y: offsetY, width: screenWidth * f, height: totalOffset)
        }
        
    }
}
