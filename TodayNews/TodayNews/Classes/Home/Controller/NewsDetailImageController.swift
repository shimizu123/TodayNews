//
//  NewsDetailImageController.swift
//  TodayNews
//
//  Created by 邓康大 on 2019/5/26.
//  Copyright © 2019 邓康大. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher
import Photos

class NewsDetailImageController: UIViewController, StoryboardLoadable, NewsDetailImageCellDelegate {
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentLabelWidth: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    /// 加 V
    @IBOutlet weak var vipImageView: UIImageView!
    
    @IBOutlet weak var avatarButton: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var abstractLabelHeight: NSLayoutConstraint!
    
    /// 收藏按钮
    @IBOutlet weak var collectButton: UIButton!
    
    var hidden: Bool = false
    
    var images = [NewsDetailImage]()
    var abstracts = [String]()
    
    var currentIndex = 0
    
    var isSelectedFirstCell = false
    
    var aNews = NewsModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    fileprivate func setupUI() {
        // 设置状态栏属性
        navigationController?.navigationBar.barStyle = .black
        SVProgressHUD.configuration()
        collectButton.setImage(UIImage(named: "icon_details_collect_press_24x24_"), for: .selected)
        collectionView.collectionViewLayout = NewsDetailImageFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.ym_registerCell(cell: NewsDetailImageCell.self)
        if aNews.comment_count == 0 {
            commentLabel.isHidden = true
        } else {
            commentLabel.text = aNews.commentCount
            switch Int32(aNews.comment_count) {
            case 0...9:
                commentLabelWidth.constant = 20
            case 10...99:
                commentLabelWidth.constant = 23
            case 100...999:
                commentLabelWidth.constant = 28
            case 1000..<INT_MAX:
                commentLabel.text = "999+"
                commentLabelWidth.constant = 36
            default:
                commentLabelWidth.constant = 20
            }
            commentLabel.layoutIfNeeded()
        }
        
        if isSelectedFirstCell { // 如果点击的第一个 cell 才去获取数据,其他情况数据从上一控制器传过来
            NetworkTool.loadNewsDetail(articleURL: aNews.article_url, completionHandler: { (images, abstracts) in
                self.images = images
                self.abstracts = abstracts
                self.collectionView.reloadData()
                self.setupAttributeString(index: 1) // 先设置好第一张图片的子标题
            })
        }
    }
    
    // 长按图片事件
    func imageViewLongPressGestureRecognizer() {
        // 暂时先用 actionSheet 吧
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let shareImageAction = UIAlertAction(title: "分享此张图片", style: .default) { _ in
            
        }
        let saveImageAction = UIAlertAction(title: "保存图片", style: .default) { _ in
            let image = self.images[self.currentIndex - 1]
            ImageDownloader.default.downloadImage(with: URL(string: image.url)!, progressBlock: { (receivedSize, totalSize) in
                // 获取当前进度
                let progress = receivedSize / totalSize
                SVProgressHUD.showProgress(Float(progress))
            }, completionHandler: { (image, error, url, data) in
                // 调用系统相册，保存到相册
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAsset(from: image!)
                }, completionHandler: { (success, error) in
                    SVProgressHUD.dismiss()
                    if success { SVProgressHUD.showSuccess(withStatus: "保存成功!") }
                })
            })
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        actionSheet.addAction(shareImageAction)
        actionSheet.addAction(saveImageAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    

}

// MARK: - 按钮点击事件
extension NewsDetailImageController {
    
    // 关闭按钮点击
    @IBAction func closeNewsDetailImageViewControllerButtonClciked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /// 头像按钮点击
    @IBAction func avatarButtonClciked(_ sender: UIButton) {
        
    }
    
    /// 更多按钮点击
    @IBAction func moreButonClicked(_ sender: UIButton) {
        
    }
    
    /// 写评论
    @IBAction func writeButtonClicked(_ sender: UIButton) {
        
    }
    
    /// 评论按钮点击
    @IBAction func commentButtonClicked(_ sender: UIButton) {
        let newsDetailCommentVC = NewsDetailImageCommentController.loadStoryboard()
        newsDetailCommentVC.aNews = aNews
        newsDetailCommentVC.modalSize = (width: .full, height: .custom(size: Float(screenHeight - (isIphoneX ? 44 : 20))))
        present(newsDetailCommentVC, animated: true, completion: nil)
    }
    
    /// 收藏按钮点击
    @IBAction func collectButtonClicked(_ sender: UIButton) {
       sender.isSelected = !sender.isSelected
        UIView.animate(withDuration: 0.15, animations: {
            sender.transform = CGAffineTransform(scaleX: 0, y: 0)
        }) { _ in
            UIView.animate(withDuration: 0.15, animations: {
                sender.transform = .identity
            })
        }
    }
    
    /// 转发按钮点击
    @IBAction func forwardButtonClicked(_ sender: UIButton) {
        
    }
}

extension NewsDetailImageController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.ym_dequeueReusableCell(indexPath: indexPath) as NewsDetailImageCell
        cell.delegate = self
        cell.index = indexPath.item + 1
        cell.count = images.count
        cell.imageView.kf.setImage(with: URL(string: images[indexPath.item].url), placeholder: nil, options: nil, progressBlock: { (receivedSize, totalSize) in
            let progress = receivedSize / totalSize
            SVProgressHUD.showProgress(Float(progress))
        }) { (image, error, cacheType, url) in
            SVProgressHUD.dismiss()
        }
        cell.abstract = abstracts[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! NewsDetailImageCell
        if hidden {
            UIView.animate(withDuration: 0.3, animations: { // 隐藏
                self.setup(cell: cell, alpha: 1)
            }, completion: { _ in
                self.hidden = false
                cell.isUserInteractionEnabled = true
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: { // 显示
                self.setup(cell: cell, alpha: 0)
            }, completion: { _ in
                self.hidden = true
                cell.isUserInteractionEnabled = true
            })
        }
    }
    
    // 设置透明度
    func setup(cell: NewsDetailImageCell, alpha: CGFloat) {
        cell.isUserInteractionEnabled = false
        closeButton.alpha = alpha
        moreButton.alpha = alpha
        avatarButton.alpha = alpha
        bottomView.alpha = alpha
        vipImageView.alpha = alpha
        abstractLabel.alpha = alpha
    }
    
    // 方式1 ，下面的代码可以和在 cell 中设置的 abstractLabel 对应来写，二者选一种
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / screenWidth) + 1
        setupAttributeString(index: currentIndex)
    }
    
    // 设置子标题
    fileprivate func setupAttributeString(index: Int) {
        let abstract = abstracts[index - 1]
        let abstractHeight = abstract.textHeight(fontSize: 18, width: screenWidth - 30)
        abstractLabelHeight.constant = abstractHeight + 5
        abstractLabel.layoutIfNeeded()
        
        let numberAttributeString = NSMutableAttributedString(string: "\(index)", attributes: [.font: UIFont.systemFont(ofSize: 17)])
        let countAttributeString = NSAttributedString(string: "/\(abstracts.count)", attributes: [.font: UIFont.systemFont(ofSize: 13)])
        numberAttributeString.append(countAttributeString)
        let abstractAttributeString = NSAttributedString(string: abstract, attributes: [.font: UIFont.systemFont(ofSize: 17)])
        numberAttributeString.append(abstractAttributeString)
        
        abstractLabel.attributedText = numberAttributeString
    }
    
}

class NewsDetailImageFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: screenWidth, height: screenHeight)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
    }
}
