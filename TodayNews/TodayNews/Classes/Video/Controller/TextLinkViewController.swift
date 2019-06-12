//
//  TextLinkViewController.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/6/8.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import WebKit

class TextLinkViewController: UIViewController {

    var url = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView(frame: self.view.bounds, configuration: WKWebViewConfiguration())
        webView.load(URLRequest(url: URL(string: url)!))
        self.view.addSubview(webView)
    }

}
