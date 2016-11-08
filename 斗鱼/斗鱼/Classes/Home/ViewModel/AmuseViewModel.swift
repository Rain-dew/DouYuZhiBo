//
//  AmuseViewModel.swift
//  斗鱼
//
//  Created by shuogao on 2016/11/7.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {
 

}
extension AmuseViewModel {

    func loadAmuseData(finishedCallback : @escaping () -> ()) {

       loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
