//
//  HomeImageCell.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/19.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class HomeImageCell: UICollectionViewCell, RegisterCellFromNib {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image = ImageList() {
        didSet {
            imageView.kf.setImage(with: URL(string: image.urlString))
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
    }

}
