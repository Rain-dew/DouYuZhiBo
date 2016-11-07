//
//  RecommendUIViewController.swift
//  斗鱼
//
//  Created by shuogao on 16/10/21.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

//常亮

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

class RecommendUIViewController: BaseAnchorViewController {

//MARK: -- 懒加载
    fileprivate lazy var recommendViewModel : RecommendViewModel = {

        let recommendViewModel = RecommendViewModel()

        return recommendViewModel
    }()
    //banner
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    //gameView
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()

}
//MARK: 设置UI界面
extension RecommendUIViewController {

    override func setupUI() {
        //先调用父类的super.setupUI()
        super.setupUI()
        view.addSubview(collectionView)

        //把banner加入到collectionView中
        collectionView.addSubview(cycleView)
        //把gameView加到collectionView中
        collectionView.addSubview(gameView)
        //设置collectionView内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}
//MARK: -- 网络请求
extension RecommendUIViewController {

    override func loadData(){

        baseVM = recommendViewModel

        recommendViewModel.requestData {
            //请求推荐数据
            self.collectionView.reloadData()
            //将数据传送给GameView
            var groups = self.recommendViewModel.anchorGroups
            //前两组数据（颜值，热门）不需要
            groups.removeFirst()
            groups.removeFirst()

            //添加一个更多
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            self.gameView.groups = groups
        }
        //请求无线轮播
        recommendViewModel.requestCycleData {

            self.cycleView.cycleModels = self.recommendViewModel.cycleModels
        }
    }
}

extension RecommendUIViewController : UICollectionViewDelegateFlowLayout {

    //cell不同 对父类方法不满意，重写它
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if  indexPath.section == 1 {
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            prettyCell.anchor = recommendViewModel.anchorGroups[indexPath.section].anchors[indexPath.item]
            return prettyCell
        }
        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}

