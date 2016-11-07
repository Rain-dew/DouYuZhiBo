//
//  GameViewController.swift
//  斗鱼
//
//  Created by shuogao on 2016/11/7.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit
private let kedgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kedgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kHeaderViewH : CGFloat = 50
private let kGameViewH : CGFloat = 90
class GameViewController: UIViewController {

    //MARK: -- 懒加载属性
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()

    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kedgeMargin, bottom: 0, right: kedgeMargin)
        //头视图
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib.init(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib.init(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        //设置collectionView内边距离
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        return collectionView
    }()
    fileprivate lazy var topHeaderView : CollectionHeaderView = {

        let topHeaderView = CollectionHeaderView.collectionHeaderView()
        topHeaderView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH)
        topHeaderView.iconImageView.image = UIImage(named: "Img_orange")
        topHeaderView.titleName.text = "常见"
        topHeaderView.moreBtn.isHidden = true
        return topHeaderView

    }()
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    //MARK: -- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //请求数据
        loadData()
    }
}
//MARK: -- 设置UI界面
extension GameViewController {

    fileprivate func setupUI() {

        view.addSubview(collectionView)
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(gameView)
    }
}
//MARK: -- 请求数据
extension GameViewController {

    fileprivate func loadData() {

        gameVM.loadAllGameData {
            //展示全部游戏

            self.collectionView.reloadData()

            //展示常用游戏(只要前十条)
//            var tempArray = [BaseGameModel]()
//            for i in 0..<10 {
//                tempArray.append(self.gameVM.games[i])
//            }

            let temp = self.gameVM.games[0..<10]  //从数组中取一个区间作为新的数组
            self.gameView.groups = Array(temp)
        }
     }
}
extension GameViewController : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        let gameModel = gameVM.games[indexPath.item]
        cell.baseGame = gameModel
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.titleName.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }
}

extension GameViewController {




}
