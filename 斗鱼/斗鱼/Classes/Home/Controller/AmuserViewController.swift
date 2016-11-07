//
//  AmuserViewController.swift
//  斗鱼
//
//  Created by shuogao on 2016/11/7.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class AmuserViewController: BaseAnchorViewController {

    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
        //MARK: -- 系统回调

}

//MARK: -- 网络请求
extension AmuserViewController {

    //重写父类的网络
    override func loadData() {
        //给viewModel赋值
        baseVM = amuseVM
        //请求数据
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
        }
    }
}
