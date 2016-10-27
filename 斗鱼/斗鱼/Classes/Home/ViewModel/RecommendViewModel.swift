//
//  RecommendViewModel.swift
//  斗鱼
//
//  Created by shuogao on 16/10/21.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class RecommendViewModel: NSObject {

    //MARK: -- 懒加载
    fileprivate lazy var anchorGroups : [AnchorGroup] = [AnchorGroup
    ]()
}

extension RecommendViewModel {

    func requestData() {

//MARK: -- 第一部分推荐数据


//MARK: -- 第二部分的颜值数据

        
//MARK: -- 后面部分的游戏数据

        NetWorkTool.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]) { (result) in
            //讲result:转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            //根据data中的key获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            //遍历数组。获取字典。并且把字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)

            }

            for group in self.anchorGroups {

                for anchor in group.anchors {

                    print(anchor.nickname)
                    print("----打印主播----")
                }
            }
        }

    }
}
