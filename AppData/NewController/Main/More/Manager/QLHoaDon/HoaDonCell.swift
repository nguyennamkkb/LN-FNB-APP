//
//  HoaDonCell.swift
//  LN FNB
//
//  Created by namnl on 30/09/2023.
//

import UIKit

class HoaDonCell: UITableViewCell {

    @IBOutlet weak var lbTien: UILabel!
    @IBOutlet weak var lbSoNguoi: UILabel!
    @IBOutlet weak var lbTenBan: UILabel!
    @IBOutlet weak var lbGioTaoHoaDon: UILabel!
    var item = FBill()
    @IBOutlet weak var vItem: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        vItem.layer.cornerRadius = C.CornerRadius.corner10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func bindData(e: FBill){
        item = e
        lbTien.text = "\(item.last_total ?? 0)".currencyFormatting()
        lbTenBan.text = item.table
        lbSoNguoi.text = "\(item.person ?? 0)"
        lbGioTaoHoaDon.text = Common.getDateFormatFromMiliseonds(time: Int64(item.updateAt ?? "0") ?? 0)
    }
}
