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
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup
    ]()//总数据
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()

}

extension RecommendViewModel {

    func requestData(finishCallBack : @escaping ()->()) {

        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]

        //创建一个组
        let dGroup = DispatchGroup()

//MARK: -- 第一部分推荐数据
        dGroup.enter()
        
        NetWorkTool.requestData(type: .post, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            //讲result:转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            //根据data中的key获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            //设置组属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            //遍历数组，转模型
            for dict in dataArray {

                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            dGroup.leave()
        }

//MARK: -- 第二部分的颜值数据
        dGroup.enter()

        NetWorkTool.requestData(type: .post, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in

            //讲result:转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            //根据data中的key获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            //设置组属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //遍历数组，转模型
            for dict in dataArray {

                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dGroup.leave()
        }
        
//MARK: -- 后面部分的游戏数据
        dGroup.enter()

        NetWorkTool.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            //讲result:转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            //根据data中的key获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            //遍历数组。获取字典。并且把字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)

            }

//            for group in self.anchorGroups {
//
//                for anchor in group.anchors {
//
////                    print(anchor.nickname)
//                }
////                print("----打印主播----")
//            }
            dGroup.leave()
        }

        //所有的请求到这里进行一个排序
        dGroup.notify(queue: DispatchQueue.main) {

            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallBack()
        }
    }
}
