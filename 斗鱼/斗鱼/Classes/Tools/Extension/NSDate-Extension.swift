
//
//  NSDate-Extension.swift
//  斗鱼
//
//  Created by shuogao on 16/10/21.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import Foundation

extension NSDate {
    //获取当前时间
    class func getCurrentTime() -> String {

        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }

}
