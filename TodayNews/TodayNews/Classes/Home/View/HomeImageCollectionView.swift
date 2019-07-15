//
//  HomeImageCollectionView.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/19.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class HomeImageCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NibLoadable {
    
    var images = [ImageList]() {
        didSet {
            self.reloadData()
        }
    }
    
    var didSelect: ((_ selectedIndex: Int)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionViewLayout = DongtaiCollectionViewFlowLayout()
        self.ym_registerCell(cell: HomeImageCell.self)
        self.delegate = self
        self.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ym_dequeueReusableCell(indexPath: indexPath) as HomeImageCell
        cell.image = images[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: image3Width, height: image3Width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelect?(indexPath.item)
    }

}
