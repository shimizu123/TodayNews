//
//  SettingViewController.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/3/9.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {
    
    // 存储 plist 文件中的数据
    var sections = [[SettingModel]]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        // 设置 UI
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sections[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as SettingCell
        cell.setting = sections[indexPath.section][indexPath.row]
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: cell.calculateDiskCacheSize() // 清理缓存，从沙盒中获取缓存数据的大小
            case 2: cell.selectionStyle = .none   // 摘要
            default: break
            }
        default: break
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! SettingCell
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: cell.clearCacheAlertController()      // 清理缓存
            case 1: cell.setupFontAlertController()       // 设置字体大小
            case 3: cell.setupNetworkAlertController()    // 非 WiFi 网络流量
            case 4: cell.setupPlayNoticeAlertController() // 非 WiFi 网络播放提醒
            default: break
            }
        case 1:
            if indexPath.row == 0 { // 离线下载
                navigationController?.pushViewController(OfflineDownloadController(), animated: true)
            }
        default: break
            
        }        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        view.theme_backgroundColor = "colors.tableViewBackgroundColor"
        return view
    }
   

    // 设置 UI
    private func setupUI() {
        // pilst 文件的路径
        let path = Bundle.main.path(forResource: "settingPlist", ofType: "plist")
        // plist 文件中的数据
        let cellPlist = NSArray(contentsOfFile: path!) as! [Any]
        sections = cellPlist.flatMap { (section) in
            (section as! [Any]).flatMap({
                SettingModel.deserialize(from: $0 as? NSDictionary)
            })
        }
        tableView.sectionHeaderHeight = 10
        tableView.ym_registerCell(cell: SettingCell.self)
        tableView.rowHeight = 44
        tableView.separatorStyle = .none
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        
    }

}
