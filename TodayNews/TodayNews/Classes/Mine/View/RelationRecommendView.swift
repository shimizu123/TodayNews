//
//  RelationRecommendView.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/3/19.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class RelationRecommendView: UIView, NibLoadable {
    
    var userCards = [UserCard]()
    
    @IBOutlet weak var labelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        collectionView.collectionViewLayout = RelationRecommendFlowLayout()
        collectionView.ym_registerCell(cell: RelationRecommendCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension RelationRecommendView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ym_dequeueReusableCell(indexPath: indexPath) as RelationRecommendCell
        cell.userCard = userCards[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

class RelationRecommendFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: 142, height: 190)
        minimumLineSpacing = 10
        scrollDirection = .horizontal
        sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
    }
}
