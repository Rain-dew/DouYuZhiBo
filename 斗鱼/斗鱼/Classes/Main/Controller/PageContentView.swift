//
//  PageContentView.swift
//  斗鱼
//
//  Created by shuogao on 16/10/20.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

//滚动代理
protocol PageContentViewDelegate : class {

    func pageContentView(_ contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

class PageContentView: UIView {


    //MARK: 自定义属性
    fileprivate var childVcs : [UIViewController]

    fileprivate var startOffsetX : CGFloat = 0

    fileprivate var isForbidScrollDelegate : Bool = false

    weak var delegate : PageContentViewDelegate?

    //使用weak不要循环引用
    fileprivate weak var parentViewController : UIViewController?

    //MARK: 懒加载
    fileprivate lazy var collctionView : UICollectionView = {[weak self] in

        //创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal

        //创建collectionView
        let collctionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collctionView.showsHorizontalScrollIndicator = false
        collctionView.isPagingEnabled = true
        collctionView.bounces = false
        collctionView.dataSource = self
        collctionView.delegate = self
        //UICollectionViewCell.self  拿到类型
        collctionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collctionView
    }()


    //MARK: 自定义构造函数
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        //设置UI
        super.init(frame: frame)
        //必须在super.init之后调用
        setupUI()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: 设置UI布局

extension PageContentView {

    fileprivate func setupUI() {

        //将所有子控制器添加到父控制器中
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)

        }
        //添加一个UICollectionView 用于在cell中存放控制器的view
        addSubview(collctionView)
        collctionView.frame = bounds
    }


}

//MARK: 遵守UICollectionViewDatasource
extension PageContentView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collctionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        //设置cell内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}
//MARK: 遵守UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {


    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }



    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        //判断是否点击事件
        if isForbidScrollDelegate {return}

        //获取需要的数据 ->
        var progress : CGFloat = 0.0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0

        //判断是左滑动还是右滑动
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width

        if currentOffsetX > startOffsetX {
            //左滑动
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            sourceIndex = Int(currentOffsetX / scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            if currentOffsetX - startOffsetX == scrollViewW {//正好滑动结束
                progress = 1
                targetIndex = sourceIndex
            }

        }else {
            //右滑动
            //计算progress  sourceIndex   targetIndex floor:取整
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }

        }

        // 将progress/sourceIndex/targetIndex传递给titleView

//        print("progress:\(progress) sourceIndex:\(sourceIndex) target:\(targetIndex)")
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }


}


//MARK: -- 对外暴露的方法
extension PageContentView {

    func setCurrentIndex(_ currentIndex : Int) {


        //记录需要禁止的代理方法
        isForbidScrollDelegate = true

        let offsetX = CGFloat(currentIndex) * collctionView.frame.width
        collctionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}




