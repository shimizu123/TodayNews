//
//  DongtaiCollectionView.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/4/9.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class DongtaiCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout,
    UICollectionViewDelegate, UICollectionViewDataSource, NibLoadable {
    
    var didSelect: ((_ selectedIndex: Int)->())?
    // 是否发布了小视频
    var isPostSmallVideo = false
    // 是否是动态详情
    var isDongtaiDetail = false
    
    var isWeitoutiao = false
    
    var largeImages = [LargeImage]()
    
    
    var thumbImages = [ThumbImage]() {
        didSet {
            reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        dataSource = self
        backgroundColor = .clear
        collectionViewLayout = DongtaiCollectionViewFlowLayout()
        isScrollEnabled = false
        ym_registerCell(cell: DongtaiCollectionViewCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ym_dequeueReusableCell(indexPath: indexPath) as DongtaiCollectionViewCell
        cell.thumbImage = thumbImages[indexPath.item]
        cell.isPostSmallVideo = isPostSmallVideo
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return isDongtaiDetail ? Calculate.detailCollectionViewCellSize(thumbImages: thumbImages) : Calculate.collectionViewCellSize(count: thumbImages.count)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isWeitoutiao {
            didSelect?(indexPath.item)
            return
        }
        let previewBigImageVC = PreviewDongtaiBigImageController()
        previewBigImageVC.images = largeImages
        previewBigImageVC.selectedIndex = indexPath.item
        UIApplication.shared.keyWindow?.rootViewController?.present(previewBigImageVC, animated: false, completion: nil)
    }

}

class DongtaiCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        minimumLineSpacing = 5
        minimumInteritemSpacing = 5
    }
}
