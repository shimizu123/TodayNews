//
//  OfflineDownloadController.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/3/10.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class OfflineDownloadController: UITableViewController {
    // 标题数组
    private var titles = [HomeNewsTitle]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "下载"
        tableView.ym_registerCell(cell: OfflineDownloadCell.self)
        tableView.rowHeight = 44
        tableView.sectionHeaderHeight = 44
        tableView.theme_separatorColor = "colors.separatorViewColor"
        tableView.theme_backgroundColor = "colors.tableViewBackgroundColor"
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        // 从数据库中取出左右数据，赋值给 标题数组 titles
        titles = NewsTitleTable().selectAll()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return OfflineSectionHeader(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
    }

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as OfflineDownloadCell
        let newsTitle = titles[indexPath.row]
        cell.titleLabel.text = newsTitle.name
        cell.rightImageView.theme_image = newsTitle.selected ? "images.air_download_option_press" : "images.air_download_option"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取出数组中的第 row 个对象
        var newsTitle = titles[indexPath.row]
        // 取反
        newsTitle.selected = !newsTitle.selected
        // 取出 第 row 个 cell
        let cell = tableView.cellForRow(at: indexPath) as! OfflineDownloadCell
        // 改变 cell 的图片
        cell.rightImageView.theme_image = newsTitle.selected ? "images.air_download_option_press" : "images.air_download_option"
        // 替换数组中的数据
        titles[indexPath.row] = newsTitle
         // 更新数据库中的数据
        NewsTitleTable().update(newsTitle: newsTitle)
        //刷新UI
        tableView.reloadRows(at: [indexPath], with: .none)
        
    }
    

   
}
