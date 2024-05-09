//
//  FavoriteCell.swift
//  IpSuiDau
//
//  Created by Ipman on 09/05/2024.
//

import UIKit

class FavoriteCell: UICollectionViewCell {

    @IBOutlet weak var _img: UIImageView!
    @IBOutlet weak var _title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _title.font = .textStyle7
        _title.textColor = .cubeColorSystemGray6
    }

}
