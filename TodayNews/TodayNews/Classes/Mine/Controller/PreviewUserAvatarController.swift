//
//  PreviewUserAvatarController.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/3/15.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD
import Photos

class PreviewUserAvatarController: UIViewController {
    
    // 头像 URL
    var avatar_url = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        let avatarImageView = UIImageView(frame: CGRect(x: 0, y: (screenHeight - screenWidth) / 2, width: screenWidth, height: screenWidth))
        avatarImageView.kf.setImage(with: URL(string: avatar_url))
        self.view.addSubview(avatarImageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: false, completion: nil)
    }
    
    // 保存图片
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        ImageDownloader.default.downloadImage(with: URL(string: avatar_url)!,
            progressBlock: { (receivedSize, totalSize) in
                let progress = receivedSize / totalSize
                SVProgressHUD.showProgress(Float(progress))
                SVProgressHUD.setBackgroundColor(.clear)
                SVProgressHUD.setForegroundColor(.white)
        }) { (image, error, imageURL, data) in
            // 调用系统相册，保存到相册
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image!)
            }, completionHandler: { (success, error) in
                if success { SVProgressHUD.showSuccess(withStatus: "保存成功!") }
            })
        }
    }
    

}
