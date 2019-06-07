//
//  TeMaiViewController.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/14.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import WebKit

class TeMaiViewController: UIViewController {

    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView(frame: self.view.bounds, configuration: WKWebViewConfiguration())
        webView.load(URLRequest(url: URL(string: url)!))
        self.view.addSubview(webView)
    }
}
