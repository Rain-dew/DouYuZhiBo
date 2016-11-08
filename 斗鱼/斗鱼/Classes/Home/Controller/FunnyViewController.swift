//
//  FunnyViewController.swift
//  斗鱼
//
//  Created by shuogao on 2016/11/8.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit
private let kTtopMargin : CGFloat = 8
class FunnyViewController: BaseAnchorViewController {

    //MARK: -- 懒加载ViewModel
    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()

}
extension FunnyViewController {

    override func setupUI() {
        super.setupUI()
        //去除header
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsetsMake(kTtopMargin, 0, 0, 0)
    }


}
extension FunnyViewController {

    override func loadData() {
        super.loadData()
        //1赋值
        baseVM = funnyVM
        //2请求数据
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
        }
    }

}
