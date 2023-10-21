//
//  BillItemCell.swift
//  LN FNB
//
//  Created by namnl on 17/10/2023.
//

import UIKit

class BillItemCell: UITableViewCell {

    @IBOutlet var lbTongTienMon: UILabel!
    @IBOutlet var lbGiaMon: UILabel!
    @IBOutlet var lbTenMon: UILabel!
    var item = FProduct()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bindData(e: FProduct){
        item = e
        lbTongTienMon.text = "\(item.total ?? 0)".currencyFormatting() + "đ"
        lbGiaMon.text = "\(item.price ?? 0)".currencyFormatting() + "đ x \(item.count ?? 0)"
        lbTenMon.text = item.name
    }

    
}
