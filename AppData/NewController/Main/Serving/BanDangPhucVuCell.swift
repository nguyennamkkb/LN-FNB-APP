//
//  BanDangPhucVuCell.swift
//  LN FNB
//
//  Created by namnl on 28/09/2023.
//

import UIKit

class BanDangPhucVuCell: UITableViewCell {
    
    var actionChon: ClosureAction?
    @IBOutlet var VLine: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        VLine.layer.shadowOpacity = 0.5
        VLine.layer.shadowOffset = CGSize(width: 0, height: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func ChonPressed(_ sender: Any) {
        actionChon?()
    }
    
}
