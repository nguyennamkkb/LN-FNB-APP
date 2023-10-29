//
//  BanDangPhucVuCell.swift
//  LN FNB
//
//  Created by namnl on 28/09/2023.
//

import UIKit

class BanDangPhucVuCell: UITableViewCell {
    
    
    @IBOutlet weak var vItem: UIView!
    var item = FOrder()
    @IBOutlet var lbSoNguoi: UILabel!
    @IBOutlet var lbTongTien: UILabel!
    @IBOutlet var lbBan: UILabel!
    var actionChon: ClosureAction?
    @IBOutlet var VLine: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        VLine.layer.shadowOpacity = 0.5
        VLine.layer.shadowOffset = CGSize(width: 0, height: 1)
    }

    func bindData(e: FOrder){
        item = e
        lbSoNguoi.text = "\(item.person ?? 0)"
        lbTongTien.text = "Tổng tiền: "+"\(item.total ?? 0)".currencyFormatting() + "đ"
        lbBan.text = "Bàn: "+"\(item.table ?? "")"
        vItem.layer.cornerRadius = C.CornerRadius.corner10
        if item.total !=  0 {
            vItem.backgroundColor = C.Color.NWhite
        }else {
            vItem.backgroundColor = UIColor(hex: "#FFFF0050")
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func ChonPressed(_ sender: Any) {
        actionChon?()
    }
    
}
