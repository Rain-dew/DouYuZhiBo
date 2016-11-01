//
//  CycleModel.swift
//  斗鱼
//
//  Created by shuogao on 2016/10/31.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    //标题
    var title : String = ""
    //图片地址
    var pic_url : String = ""
    //主播信息对应的字典
    var room : [String : Any]? {

        didSet {

            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room)
        }
    }

    //定义一个主播模型对象
    var anchor : AnchorModel?

    //定义个构造函数.kvc

    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }

}
