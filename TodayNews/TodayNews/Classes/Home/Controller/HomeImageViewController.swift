//
//  HomeImageViewController.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/14.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class HomeImageViewController: HomeTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    

    // MARK: - Table view data source

//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//    }
   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        

        return cell
    }
    

}
