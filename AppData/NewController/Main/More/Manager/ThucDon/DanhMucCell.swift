//
//  DanhMucCell.swift
//  LN FNB
//
//  Created by namnl on 28/09/2023.
//

import UIKit

class DanhMucCell: UITableViewCell {

    @IBOutlet var bDelete: UIButton!
    @IBOutlet var bEdit: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        bDelete.layer.cornerRadius = C.CornerRadius.corner5
        bEdit.layer.cornerRadius = C.CornerRadius.corner5
    }

    
}
