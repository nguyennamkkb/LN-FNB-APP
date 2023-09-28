//
//  QLMonAnCell.swift
//  LN FNB
//
//  Created by namnl on 28/09/2023.
//

import UIKit

class QLMonAnCell: UITableViewCell {

    @IBOutlet var bDelete: UIButton!
    @IBOutlet var bEdit: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        bEdit.layer.cornerRadius = C.CornerRadius.corner5
        bDelete.layer.cornerRadius = C.CornerRadius.corner5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
