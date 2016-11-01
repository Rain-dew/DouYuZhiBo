//
//  RecommendCycleView.swift
//  斗鱼
//
//  Created by shuogao on 2016/10/31.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit
private let kCycleCellID = "kCycleCellID"
class RecommendCycleView: UIView {

    //定义属性
    var cycleModels : [CycleModel]? {

        didSet {
            //刷新collectionView
            collectionView.reloadData()
            //设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!

    override func awakeFromNib() {
         super.awakeFromNib()
        //设置该空间不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()

        //注册cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    override func layoutSubviews() {
        //设置layout(获取的尺寸准确，所以在这里设置)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true

    }
}

//MARK: -- 提供一个快创建View的类方法

extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return (Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as? RecommendCycleView)!
    }
}

//MARK: -- 遵守UICollectionView数据源代理
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        let cycleModel = cycleModels![indexPath.item]

        cell.cycleModel = cycleModel

        return cell
    }
}
//MARK: -- 遵守UICollectionView代理
extension RecommendCycleView : UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5

        pageControl.currentPage = Int(offsetX / scrollView.bounds.width)
    }


}
