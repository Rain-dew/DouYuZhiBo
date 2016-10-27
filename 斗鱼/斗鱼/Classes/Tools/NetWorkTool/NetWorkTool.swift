//
//  NetWorkTool.swift
//  斗鱼
//
//  Created by shuogao on 16/10/21.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType {
    case get
    case post
}

class NetWorkTool {

    class func requestData(type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping (_ result : Any) -> ()) {

        //获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON {
            (response) in

            //获取结果
            guard let  result = response.result.value else {

                print(response.result.error)
                return
            }
            
            finishedCallback(result)
        }
    }
}
