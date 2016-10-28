//
//  AnchorGroup.swift
//  斗鱼
//
//  Created by shuogao on 16/10/21.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    //该组对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    //组显示的标题
    var tag_name : String = ""
    //组显示的图标
    var icon_name : String = "home_header_normal"

    //定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    override init(){


    }
    init(dict : [String : NSObject]) {
        super.init()
        //KVC
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
