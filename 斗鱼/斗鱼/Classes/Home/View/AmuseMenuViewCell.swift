//
//  AmuseMenuViewCell.swift
//  斗鱼
//
//  Created by shuogao on 2016/11/8.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit
private let kGameCell = "gameCell"
class AmuseMenuViewCell: UICollectionViewCell {
//MARK: -- 数组模型
    var groups : [AnchorGroup]? {
        didSet {

            collectionView.reloadData()
        }
    }
    @IBOutlet var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()

        //注册
        collectionView.register(UINib.init(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCell)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: itemW, height: itemH)

    }

}



//MARK: -- UICollectionViewDataSource
extension AmuseMenuViewCell : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCell, for: indexPath) as! CollectionGameCell
        cell.clipsToBounds = true//去掉下面的线条
        cell.baseGame = groups![indexPath.item]
        return cell
    }

}
