//
//  CollectionPrettyCell.swift
//  斗鱼
//
//  Created by shuogao on 16/10/21.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionPrettyCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cityLabel: UIButton!
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var onLineLabel: UILabel!
    //定义模型属性
    var anchor : AnchorModel? {

        didSet {
            //取出在线人数
            guard let anchor = anchor else { return }
            //在线人数显示文字处理
            var onlineStr : String = ""

            if anchor.online >= 10000 {

                onlineStr = "\(Int(anchor.online / 10000))万在线"

            }else {

                onlineStr = "\(anchor.online)在线"
            }
            onLineLabel.text = onlineStr
            //城市赋值
            nickNameLabel.text = anchor.nickname
            //昵称赋值
            cityLabel.setTitle(anchor.anchor_city, for: .normal)
            //设置封面
            guard let iconURL = URL(string: anchor.vertical_src)else { return }
            imageView.kf.setImage(with: iconURL)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        //设置圆角
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        onLineLabel.layer.cornerRadius = 3
        onLineLabel.layer.masksToBounds = true

    }



}
