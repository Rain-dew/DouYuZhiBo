//
//  CollectionGameCell.swift
//  斗鱼
//
//  Created by shuogao on 2016/11/7.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {

    //空间属性
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    var baseGame : BaseGameModel? {

        didSet {

            titleLabel.text = baseGame?.tag_name
            let iconURL = URL(string: baseGame?.icon_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_more_btn"))
        }

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = 22.5
        iconImageView.layer.masksToBounds = true
    }

}
