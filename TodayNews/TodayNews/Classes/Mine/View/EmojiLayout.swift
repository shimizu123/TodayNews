//
//  EmojiLayout.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/4/24.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

class EmojiLayout: UICollectionViewFlowLayout {
    
    //列
    var columns = 7
    //行
    var rows = 3
    // 保存所有的 item
    var attributes = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: emojiItemWidth, height: emojiItemWidth)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        
        let margin = (collectionView!.height - emojiItemWidth * 3) / 2
        collectionView?.contentInset = UIEdgeInsetsMake(margin, 0, margin, 0)
        
        var page = 0
        // item 的个数
        let items = collectionView?.numberOfItems(inSection: 0)
        // 遍历
        for item in 0..<items! {
            let indexPath = IndexPath(item: item, section: 0)
            let layoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            page = item / (columns * rows)
            // 通过一系列计算，得到x，y
            let x = itemSize.width * CGFloat(item % columns) + CGFloat(page) * screenWidth
            let y = itemSize.height * CGFloat((item - page * rows * columns) / columns)
            layoutAttributes.frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
            // 把每一个新的属性保存起来，放到数组中
            attributes.append(layoutAttributes)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return super.collectionViewContentSize
    }
    
    // 每一个元素的布局属性
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes.filter({ rect.contains($0.frame) })
    }
    
}
