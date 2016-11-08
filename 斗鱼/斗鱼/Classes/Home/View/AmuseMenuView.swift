//
//  AmuseMenuView.swift
//  斗鱼
//
//  Created by shuogao on 2016/11/8.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit
private let kMenuCellID = "kMenuCellID"
class AmuseMenuView: UIView {
//MARK: -- 定义属性
    var groups : [AnchorGroup]? {
        didSet {

            collectionView.reloadData()
        }

    }
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()

        //让空间不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()

        collectionView.register(UINib.init(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //重新设置布局
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }

}
//MARK: xib创建的类方法
extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}
//MARK: UICollectionViewDataSource
extension AmuseMenuView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil {
            return 0
        }
        //计算有多少页的算法
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuViewCell
        setupCelldataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    private func setupCelldataWithCell(cell : AmuseMenuViewCell, indexPath : IndexPath) {

        //0页 0--7
        //1页 8--15
        //2页 16--23
        //取出起点位置
        let startIndex = indexPath.item * 8
        //终点位置
        var endIndex = (indexPath.item + 1) * 8 - 1
        //判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        //取出数据，并且赋值给cell
        cell.groups = Array(groups![startIndex...endIndex])
    }
}
//MARK: -- UICollectionViewDelegate
extension AmuseMenuView : UICollectionViewDelegate {
//设置page的变化
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
