//
//  PersonViewController.swift
//  斗鱼
//
//  Created by shuogao on 2016/10/31.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0..<4 {
            let imageview = UIImageView(frame: CGRect(x: 100, y: 55*i+64, width: 50, height: 50))
            imageview.isUserInteractionEnabled = true
            imageview.tag = i
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapGes(tap:)))
            imageview.addGestureRecognizer(tap)
            imageview.backgroundColor = .red
            view.addSubview(imageview)
        }
    }
    func tapGes(tap: UITapGestureRecognizer) {
        guard let view = tap.view as? UIImageView else {
            return
        }
        switch view.tag {
        case 0:
            print("0")
        case 1:
            print("1")
        case 2:
            print("2")
        default:
            print("3")
        }
    }
}
