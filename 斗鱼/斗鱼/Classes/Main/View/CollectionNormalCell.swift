//
//  CollectionNormalCell.swift
//  斗鱼
//
//  Created by shuogao on 16/10/21.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var roomNameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var onlineBtn: UIButton!
    @IBOutlet var iconImageView: UIImageView!

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
            onlineBtn.setTitle(onlineStr, for: .normal)

            //昵称赋值
            nickNameLabel.text = anchor.nickname
            //房间
            roomNameLabel.text = anchor.room_name
            //设置封面
            guard let iconURL = URL(string: anchor.vertical_src)else { return }
            imageView.kf.setImage(with: iconURL)
        }
    }



    override func awakeFromNib() {
        super.awakeFromNib()

        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
    }

}
