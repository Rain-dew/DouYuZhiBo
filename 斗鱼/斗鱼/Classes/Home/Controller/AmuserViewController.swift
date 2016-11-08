//
//  AmuserViewController.swift
//  斗鱼
//
//  Created by shuogao on 2016/11/7.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit
private let kMenuViewH : CGFloat = 200
class AmuserViewController: BaseAnchorViewController {

    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {

        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
        //MARK: -- 系统回调

}

//MARK: -- 设置UI界面 重写父类方法
extension AmuserViewController {
    override func setupUI() {
        super.setupUI()

        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
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
            //顶部的滚动数据
            var temp = self.amuseVM.anchorGroups
            temp.removeFirst()
            self.menuView.groups = temp
        }
    }
}
