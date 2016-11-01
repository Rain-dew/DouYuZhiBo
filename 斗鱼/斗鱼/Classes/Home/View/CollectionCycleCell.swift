//
//  CollectionCycleCell.swift
//  斗鱼
//
//  Created by shuogao on 2016/10/31.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet var iconImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!

    var cycleModel : CycleModel? {

        didSet {

            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }
    }

}
