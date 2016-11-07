//
//  RecommendGameView.swift
//  斗鱼
//
//  Created by shuogao on 2016/11/7.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit
private let kGameCell = "kGameCell"
class RecommendGameView: UIView {

    //MARK: -- 定义数据属性
    var groups : [AnchorGroup]? {

        didSet {
            //前两组数据（颜值，热门）不需要
            groups?.removeFirst()
            groups?.removeFirst()

            //添加一个更多
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)

            collectionView.reloadData()
        }
    }



    @IBOutlet var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()


        //让空间不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()

        //注册cell
        collectionView.register(UINib.init(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCell)
    }

}
extension RecommendGameView {

    class func recommendGameView() -> RecommendGameView {

        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)!.first as! RecommendGameView
    }

}
//MARK: -- UICollectionViewDataSource
extension RecommendGameView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCell, for: indexPath) as! CollectionGameCell
        cell.backgroundColor = .clear
        cell.group = groups![indexPath.item]
        return cell
    }

}
