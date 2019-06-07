//
//  DongtaiOriginThreadView.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/4/9.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class DongtaiOriginThreadView: UIView, NibLoadable {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: DongtaiCollectionView!
    @IBOutlet weak var collectionViewWidth: NSLayoutConstraint!
    
    
    var isPostSmallVideo = false
    
    var originThread = DongtaiOriginThread() {
        didSet {
            // 如果原内容已经删除
            if originThread.delete || !originThread.show_origin {
                contentLabel.text = originThread.show_tips != "" ? originThread.show_tips : originThread.content
                contentLabel.textAlignment = .center
            } else {
                contentLabel.attributedText = originThread.attributedContent
                collectionView.isDongtaiDetail = originThread.isDongtaiDetail
                collectionView.thumbImages = originThread.thumb_image_list
                collectionView.largeImages = originThread.large_image_list
                collectionViewWidth.constant = originThread.collectionViewW
            }
            
            contentLabelHeight.constant = originThread.contentH
            layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.grayColor247"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.width = screenWidth
        self.height = originThread.height
    }

}
