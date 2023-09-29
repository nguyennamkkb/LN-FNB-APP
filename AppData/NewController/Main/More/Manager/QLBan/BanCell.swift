//
//  BanCell.swift
//  LN FNB
//
//  Created by namnl on 29/09/2023.
//

import UIKit

class BanCell: UITableViewCell {

    var actionEdit: ClosureAction?
    var actionDelete: ClosureAction?
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
    @IBAction func editPressed(_ sender: Any) {
        actionEdit?()
    }
    @IBAction func deletePressed(_ sender: Any) {
        actionDelete?()
    }
}
