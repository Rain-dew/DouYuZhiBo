//
//  BaseViewModel.swift
//  斗鱼
//
//  Created by shuogao on 2016/11/7.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup
        ]()//总数据
}
extension BaseViewModel {

    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetWorkTool.requestData(type: .get, URLString: URLString) { (result) in
            //获取到数组
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }

            //判断是否是分组数据
            if  isGroupData {
                //字典转模型
                for dict in dataArray {
                    let group = AnchorGroup(dict: dict)
                    self.anchorGroups.append(group)
                }

            }else {

                //如果不是，创建一个
                let group = AnchorGroup()
                //遍历dataArray所有字典
                for dict in dataArray {

                    group.anchors.append(AnchorModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }

            //完成回调
            finishedCallback()
        }
    }
}
