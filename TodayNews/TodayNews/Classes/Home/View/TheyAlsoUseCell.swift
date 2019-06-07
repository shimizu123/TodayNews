//
//  TheyAlsoUseCell.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/18.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class TheyAlsoUseCell: UITableViewCell, RegisterCellFromNib {
    
    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var theyUse = SmallVideo() {
        didSet {
            leftLabel.text = theyUse.title
            rightButton.setTitle(theyUse.show_more, for: .normal)
            userCards = theyUse.user_cards
            collectionView.reloadData()
        }
    }
    
    var userCards = [UserCard]()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
        bottomView.theme_backgroundColor = "colors.separatorViewColor"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = TheyAlsoCollectionViewFlowLayout()
        collectionView.ym_registerCell(cell: TheyUseCollectionCell.self)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TheyAlsoUseCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ym_dequeueReusableCell(indexPath: indexPath) as TheyUseCollectionCell
        cell.userCard = userCards[indexPath.item]
        
        return cell
    }
    
}

class TheyAlsoCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: 170, height: 215)
        sectionInset = UIEdgeInsetsMake(5, 15, 10, 10)
        scrollDirection = .horizontal
    }
}
