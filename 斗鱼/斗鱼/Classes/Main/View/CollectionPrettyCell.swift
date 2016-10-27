//
//  CollectionPrettyCell.swift
//  斗鱼
//
//  Created by shuogao on 16/10/21.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

import UIKit

class CollectionPrettyCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!

    @IBOutlet var onLineLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        onLineLabel.layer.cornerRadius = 3
        onLineLabel.layer.masksToBounds = true
    }

}
