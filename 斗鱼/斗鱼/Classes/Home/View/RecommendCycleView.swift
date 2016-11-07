//
//  RecommendCycleView.swift
//  斗鱼
//
//  Created by shuogao on 2016/10/31.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit
private let kCycleCellID = "kCycleCellID"
private let kEdgeInsetMargin : CGFloat = 10
class RecommendCycleView: UIView {

    //定义属性

    //定时器
    var cycleTimer : Timer?


    //数据模型
    var cycleModels : [CycleModel]? {

        didSet {
            //刷新collectionView
            collectionView.reloadData()
            //设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            //默认滚动到中间某个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            //有数据就添加定时器。先移除再添加
            removeCycleTimer()
            addCycleTimer()
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
        //添加一个内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: kEdgeInsetMargin)
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
        return (cycleModels?.count ?? 0) * 10000
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell

        let cycleModel = cycleModels![indexPath.item % cycleModels!.count]//取模

        cell.cycleModel = cycleModel

        return cell
    }
}
//MARK: -- 遵守UICollectionView代理
extension RecommendCycleView : UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5

        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }

//当用户拖拽时，移除定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

        removeCycleTimer()
    }
//停止拖拽，加入定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }


}

//MARK: -- 定时器操作方法
extension RecommendCycleView {

    fileprivate func addCycleTimer(){

        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    fileprivate func removeCycleTimer() {

        cycleTimer?.invalidate()//移除
        cycleTimer = nil
    }
    @objc private func scrollToNextPage() {

        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        //滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)

    }
}











