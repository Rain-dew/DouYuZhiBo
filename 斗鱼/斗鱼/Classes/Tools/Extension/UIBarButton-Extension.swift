//
//  UIBarButton-Extension.swift
//  斗鱼
//
//  Created by shuogao on 16/10/19.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    convenience init(imageName: String, hightImageName : String = "", size : CGSize = CGSize.zero) {

        // 1.创建UIButton
        let btn = UIButton()

        // 2.设置btn的图片
        btn.setImage(UIImage(named: imageName), for: UIControlState())
        if hightImageName != "" {
            btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        }

        // 3.设置btn的尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }

        // 4.创建UIBarButtonItem
        self.init(customView : btn)

    }

}
