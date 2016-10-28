//
//  CollectionHeaderView.swift
//  斗鱼
//
//  Created by shuogao on 16/10/21.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    @IBOutlet var titleName: UILabel!

    @IBOutlet var iconImageView: UIImageView!
    var group : AnchorGroup? {

            didSet {

                titleName.text = group?.tag_name
                iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")//如没有值传入默认图片
            }
        }
    override func awakeFromNib() {

        super.awakeFromNib()

    }
    
}
