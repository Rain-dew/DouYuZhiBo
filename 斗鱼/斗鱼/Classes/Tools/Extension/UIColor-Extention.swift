
//
//  UIColor-Extention.swift
//  斗鱼
//
//  Created by shuogao on 16/10/20.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {

        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }

}
