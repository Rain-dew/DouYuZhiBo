//
//  PageTitleView.swift
//  斗鱼
//
//  Created by shuogao on 16/10/20.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

//代理

protocol PageTitleViewDelegate : class {

    func pageTitleView(_ titleView : PageTitleView, selectedIndex index: Int)
}


private let kScrollLineH : CGFloat = 2
//定义元祖颜色
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)//灰色
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)//橘黄色

class PageTitleView: UIView {

    //MARK: 自定义属性
    fileprivate var titles: [String]

    fileprivate var currentIndex : Int = 0

    weak var delegate : PageTitleViewDelegate?
    //MARKa: 懒加载属性
    fileprivate lazy var scrollView : UIScrollView = {

        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()

    //label
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()


    //滚动条
    fileprivate lazy var scrollLine : UIView = {

        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        return scrollLine
    }()

    //MARK: 自定义构造函数
    init(frame: CGRect, titles: [String]) {

        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension PageTitleView {

//fileprivate 本文件私有 private本方法私有  默认不写是公开


    fileprivate func setupUI() {

        //添加滚动视图
        addSubview(scrollView)
        scrollView.frame = bounds

        //添加title对应的Label
        setupTitleLabels()

        //设置滑块
        setupBottomLine()
    }

    private func setupTitleLabels() {

        //设置label的frame
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0


        for (index, title) in titles.enumerated() {

            //创建label
            let labelX : CGFloat = labelW * CGFloat(index)

            let label = UILabel(frame: CGRect(x: labelX, y: labelY, width: labelW, height: labelH))

            //设置label的属性
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            label.text = title
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.tag = index


            //添加到scrollView
            scrollView.addSubview(label)
            //把label放进数组
            titleLabels.append(label)

            //给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.tittleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    private func setupBottomLine() {

        let bottomLine = UIView()
        bottomLine.backgroundColor = .lightGray
        let bottomLineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - bottomLineH, width: frame.width, height: bottomLineH)
        addSubview(bottomLine)

        scrollView.addSubview(scrollLine)

        //拿到第一个label的frame
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)//默认颜色
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

//MARK: 标题点击的事件处理

extension PageTitleView {

    @objc fileprivate func tittleLabelClick(tapGes : UITapGestureRecognizer) {

        //获取当前的label

        guard let currentLabel = tapGes.view as? UILabel else { return }

        //获取之前的label
        let oldLabel = titleLabels[currentIndex]

        //切换文字颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        //保存最新label的下标值
        currentIndex = currentLabel.tag

        //滚动条的变化->改变origin.x即可
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width

        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        //通知代理
        delegate?.pageTitleView(self, selectedIndex: currentIndex)

    }

}

//MARK: 公开方法
extension PageTitleView {

    func setTileWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        //取出sourceLabel / targetLabel

        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]

        //处理滑块的联动
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX

        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)

        // 3.2.变化sourceLabel    由橘黄色->灰色
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)

        // 3.2.变化targetLabel - > 由灰色->橘黄色
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)

        //记录最新的index
        currentIndex = targetIndex
    }

}


