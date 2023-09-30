//
//  BanDatTruocCell.swift
//  LN FNB
//
//  Created by namnl on 29/09/2023.
//

import UIKit

class BanDatTruocCell: UITableViewCell {

    var actionDelete: ClosureAction?
    @IBOutlet var bDelete: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        bDelete.layer.cornerRadius = C.CornerRadius.corner5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deletePressed(_ sender: Any) {
        actionDelete?()
    }
    
}
