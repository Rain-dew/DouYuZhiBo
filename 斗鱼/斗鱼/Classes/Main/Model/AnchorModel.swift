//
//  AnchorModel.swift
//  斗鱼
//
//  Created by shuogao on 16/10/21.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {

    //房间ID
    var room_id : Int = 0

    //房间图对应的URLString
    var vertical_src : String = ""

    //判断是手机直播还是电脑直播 0是电脑  1是手机
    var isVertical : Int = 0

    //房间名称
    var room_name : String = ""

    //主播昵称
    var nickname : String = ""

    //在线人数
    var online : Int = 0


    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

   
}
