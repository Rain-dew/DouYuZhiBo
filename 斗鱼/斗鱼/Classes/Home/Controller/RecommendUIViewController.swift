//
//  RecommendUIViewController.swift
//  斗鱼
//
//  Created by shuogao on 16/10/21.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

//常亮
private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kItemH : CGFloat = kItemW * 3 / 4
private let kItemPrettyH : CGFloat = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50
private let kNormalCellID = "NormalCellID"
private let kPrettyCellID = "PrettyCellID "
private let kHeaderViewID = "HeaderViewID"
class RecommendUIViewController: UIViewController {



//MARK: -- 懒加载
    fileprivate lazy var recommendViewModel : RecommendViewModel = {

        let recommendViewModel = RecommendViewModel()

        return recommendViewModel
    }()


    fileprivate lazy var collectionView : UICollectionView = {[weak self] in

        //创建布局
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: kItemW, height: kItemH)
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


    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setupUI()
        //网络请求
        loadData()

    }

}
//MARK: -- 网络请求
extension RecommendUIViewController {

    fileprivate func loadData(){

        recommendViewModel.requestData()

    }
    
}

//MARK: 设置UI界面
extension RecommendUIViewController {

    fileprivate func setupUI() {

        view.addSubview(collectionView)
    }


}
//MARK: -- UICollectionViewDataSource
extension RecommendUIViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)

        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出section的headerview

        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)

        return headerView
    }
    //调节大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kItemPrettyH)
        }
        return CGSize(width: kItemW, height: kItemH)
    }
}








