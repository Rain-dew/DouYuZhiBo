//
//  BaseAnchorViewController.swift
//  斗鱼
//
//  Created by shuogao on 2016/11/7.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit
//常亮
private let kItemMargin : CGFloat = 10
let kNormalItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH : CGFloat = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50
private let kNormalCellID = "NormalCellID"
let kPrettyCellID = "PrettyCellID "
private let kHeaderViewID = "HeaderViewID"

class BaseAnchorViewController: UIViewController {

    //MARK: -- 定义属性
    var baseVM : BaseViewModel!
    lazy var collectionView : UICollectionView = {[weak self] in

        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        //让视图随着父视图的宽高拉伸而拉伸
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //注册单元格
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        //注册表头
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)

        return collectionView
        }()

    //MARK: -- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI
        setupUI()
        loadData()
    }
}
//MARK: -- 设置UI界面
extension BaseAnchorViewController {

    func setupUI() {
        view.addSubview(collectionView)
    }
    
}
//MARK: -- 网络请求
extension BaseAnchorViewController {
    func loadData() {

    }
}

//MARK: -- UICollectionViewDataSource
extension BaseAnchorViewController : UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return baseVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell

        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]

        return cell

    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出section的headerview

        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        //取出模型
  
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
    
}
