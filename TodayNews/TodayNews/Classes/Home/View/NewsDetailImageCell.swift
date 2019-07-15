//
//  NewsDetailImageCell.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/27.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit

protocol NewsDetailImageCellDelegate: class {
    func imageViewLongPressGestureRecognizer()
}

class NewsDetailImageCell: UICollectionViewCell, RegisterCellFromNib {
    
    @IBOutlet weak var abstractLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var abstractLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    weak var delegate: NewsDetailImageCellDelegate?
    
    var index = 0
    var count = 0
    
    var abstract = "" {
        didSet {
            let abstractHeight = abstract.textHeight(fontSize: 18, width: screenWidth - 30)
            abstractLabelHeight.constant = abstractHeight + 5
            self.layoutIfNeeded()
            
            let numberAttributeString = NSMutableAttributedString(string: "\(index)", attributes: [.font: UIFont.systemFont(ofSize: 17)])
            let countAttributeString = NSAttributedString(string: "/\(count)", attributes: [.font: UIFont.systemFont(ofSize: 13)])
            numberAttributeString.append(countAttributeString)
            let abstractAttributeString = NSAttributedString(string: abstract, attributes: [.font: UIFont.systemFont(ofSize: 17)])
            numberAttributeString.append(abstractAttributeString)
            // 方式2 ，和图片详情控制器里在 scrollView 的的代理里设置二者择一
          //  abstractLabel.attributedText = numberAttributeString
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        let longRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longRecognizerEvent))
        imageView.addGestureRecognizer(longRecognizer)
    }
    
    @objc func longRecognizerEvent() {
        delegate?.imageViewLongPressGestureRecognizer()
    }

}
