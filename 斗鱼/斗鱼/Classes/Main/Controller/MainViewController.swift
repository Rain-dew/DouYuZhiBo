//
//  MainViewController.swift
//  斗鱼
//
//  Created by shuogao on 16/10/19.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit



class MainViewController: UITabBarController {
       override func viewDidLoad() {
        super.viewDidLoad()

        //添加storyBord控制器
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Mine")

    }


    func addChildVC(storyName : String) {

        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()
        addChildViewController(childVC!)
    }

}
