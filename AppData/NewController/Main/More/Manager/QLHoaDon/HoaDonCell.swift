//
//  HoaDonCell.swift
//  LN FNB
//
//  Created by namnl on 30/09/2023.
//

import UIKit

class HoaDonCell: UITableViewCell {

    @IBOutlet weak var vItem: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        vItem.layer.cornerRadius = C.CornerRadius.corner10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
