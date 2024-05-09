//
//  NotificationCell.swift
//  IpSuiDau
//
//  Created by Ipman on 09/05/2024.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var _imgDot: UIImageView!
    @IBOutlet weak var _title: UILabel!
    @IBOutlet weak var _date: UILabel!
    @IBOutlet weak var _content: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _imgDot.layer.cornerRadius = _imgDot.bounds.height / 2
        _imgDot.backgroundColor = .orange01
        
        _title.font = .textStyle5
        _title.textColor = .cubeColorSystemGray10
        
        _date.font = .textStyle6
        _date.textColor = .cubeColorSystemGray10
        
        _content.font = .textStyle16Regular
        _content.textColor = .battleshipGrey
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
