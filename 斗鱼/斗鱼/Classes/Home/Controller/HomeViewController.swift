//
//  HomeViewController.swift
//  斗鱼
//
//  Created by shuogao on 16/10/19.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

//pageView高度
private let KtitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    //MARK:懒加载

    

    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in

        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: KtitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()

    fileprivate lazy var pageContentView :PageContentView = {[weak self] in

        let contentViewH = kScreenH - kStatusBarH - kNavigationBarH - KtitleViewH - kTabBarH
        let contentViewFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + KtitleViewH, width: kScreenW, height: contentViewH)
        var childVcs = [UIViewController]()
        //加入一个初始化的推荐控制器
        childVcs.append(RecommendUIViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuserViewController())

        for _ in 0..<1 {

            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)

        }
        let contentView = PageContentView(frame: contentViewFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setupUI()
        //网络请求  
    }

}

//MARK: -- 设置UI界面
extension HomeViewController {

    fileprivate func setupUI() {

        //不需要调整scroll的内边距
        automaticallyAdjustsScrollViewInsets = false

        //设置导航栏
        setupNavigationBar()

        //添加titleView
        view.addSubview(pageTitleView)

        //添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple

    }

    fileprivate func setupNavigationBar () {

        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")

        let size = CGSize(width: 40, height: 40)

        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightImageName: "Image_my_history_click", size: size)

        let searchItem = UIBarButtonItem(imageName: "btn_search", hightImageName: "btn_search_clicked", size: size)

        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", hightImageName: "Image_scan_click", size: size)

        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]

    }

}
//MARK: PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }

}
//MARK: PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate {

    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTileWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
