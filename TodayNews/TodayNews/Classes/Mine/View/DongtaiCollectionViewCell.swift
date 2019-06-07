//
//  DongtaiCollectionViewCell.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/4/10.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import SVProgressHUD

class DongtaiCollectionViewCell: UICollectionViewCell, RegisterCellFromNib {

    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var iconButton: UIButton!
    
    @IBOutlet weak var gifLabel: UILabel!
    
    var isPostSmallVideo = false {
        didSet {
            iconButton.theme_setImage(isPostSmallVideo ? "images.smallvideo_all_32x32_" : nil, forState: .normal)
        }
    }
    
    var thumbImage = ThumbImage() {
        didSet {
            thumbImageView.kf.setImage(with: URL(string: thumbImage.urlString))
            gifLabel.isHidden = !(thumbImage.type == .gif)
        }
    }
    
    var largeImage = LargeImage() {
        didSet {
            thumbImageView.kf.setImage(with: URL(string: largeImage.urlString), placeholder: nil, options: nil, progressBlock: { (receivedSize, totalSize) in
                let progress = receivedSize / totalSize
                SVProgressHUD.showProgress(Float(progress))
                SVProgressHUD.setBackgroundColor(.clear)
                SVProgressHUD.setForegroundColor(.white)
            }) { (image, error, cacheType, url) in
                SVProgressHUD.dismiss()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImageView.layer.theme_borderColor = "colors.grayColor230"
        thumbImageView.layer.borderWidth = 1
        theme_backgroundColor = "colors.cellBackgroundColor"
    }

}
