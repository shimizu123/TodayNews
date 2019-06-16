//
//  HomeJokeViewController.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/14.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class HomeJokeViewController: HomeTableViewController {
    
    // 是否是段子
    var isJoke = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.ym_registerCell(cell: HomeJokeCell.self)
    }

    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let aNews = news[indexPath.row]
        return isJoke ? aNews.jokeCellHeight : aNews.girlCellHeight
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ym_dequeueReusableCell(indexPath: indexPath) as HomeJokeCell
        cell.joke = news[indexPath.row]
        cell.isJoke = isJoke

        return cell
    }
    
}
