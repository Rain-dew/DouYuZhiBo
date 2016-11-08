//
//  FunnyViewModel.swift
//  斗鱼
//
//  Created by shuogao on 2016/11/8.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class FunnyViewModel : BaseViewModel{

}
extension FunnyViewModel {

    func loadFunnyData(finishedCallback : @escaping () -> ()) {

        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
        
    }

}
