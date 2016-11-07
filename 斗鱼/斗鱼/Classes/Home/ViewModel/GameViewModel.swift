//
//  GameModel.swift
//  斗鱼
//
//  Created by shuogao on 2016/11/7.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class GameViewModel {

    lazy var games : [GameModel] = [GameModel]()


}
extension GameViewModel {

    func loadAllGameData(_ finishCallback : @escaping () -> ()) {

        NetWorkTool.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in

            //获取到数组
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            //字典转模型
            for dict in dataArray {

                self.games.append(GameModel(dict: dict))
            }
            //完成回调
            finishCallback()
        }
        
    }

}
