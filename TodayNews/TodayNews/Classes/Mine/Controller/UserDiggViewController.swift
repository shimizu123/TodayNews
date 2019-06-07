//
//  UserDiggViewController.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/4/22.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import SVProgressHUD

class UserDiggViewController: UITableViewController {
    
    var userId = 0
    
    var diggList = [DongtaiUserDigg]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.configuration()
        self.title = "赞过的人"
        tableView.ym_registerCell(cell: UserDiggCell.self)
        tableView.mj_footer = RefreshAutoGifFooter(refreshingBlock: { [weak self] in
            // 获取动态详情的用户点赞列表数据
            NetworkTool.loadDongtaiDetailUserDiggList(id: self!.userId, offset: self!.diggList.count, completionHandler: {
                if self!.tableView.mj_footer.isRefreshing {
                    self!.tableView.mj_footer.endRefreshing()
                }
                self!.tableView.mj_footer.pullingPercent = 0.0
                if $0.count == 0 {
                    self?.tableView.mj_footer.endRefreshingWithNoMoreData()
                    SVProgressHUD.showInfo(withStatus: "没有更多数据啦!")
                    return
                }
                self?.diggList = $0
                self?.tableView.reloadData()
            })
        })
        tableView.mj_footer.beginRefreshing()
    }

   

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return diggList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as UserDiggCell
        cell.user = diggList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = diggList[indexPath.row]
        let userDetailVC = UserDetailViewController()
        userDetailVC.userId = user.user_id
        navigationController?.pushViewController(userDetailVC, animated: true)
    }

}
