//
//  BanDatTruocCell.swift
//  LN FNB
//
//  Created by namnl on 29/09/2023.
//

import UIKit

class BanDatTruocCell: UITableViewCell {
    
    
    @IBOutlet weak var vItem: UIView!
    @IBOutlet var lbGhiChu: UILabel!
    var item: FOrder  = FOrder()
    @IBOutlet weak var lbSoNguoi: UILabel!
    @IBOutlet weak var lbThoiGIanDen: UILabel!
    @IBOutlet weak var lbTenBan: UILabel!
    var actionDelete: ClosureCustom<FOrder>?
    var actionUpdate: ClosureCustom<FOrder>?
    @IBOutlet var bDelete: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        vItem.layer.cornerRadius = C.CornerRadius.corner10
    }
    func binđata(e: FOrder){
        item = e
        lbTenBan.text = "Bàn: " + (item.table ?? "")
        lbSoNguoi.text = "\(item.person ?? 0)"
        lbThoiGIanDen.text = "\(Common.getDateFormatFromMiliseonds(time:Int64(item.time ?? "0") ?? 0))"
        lbGhiChu.text = item.note ?? ""
    }
    @IBAction func deletePressed(_ sender: Any) {
        actionDelete?(item)
    }
    @IBAction func suaDatBanPressed(_ sender: Any) {
        actionUpdate?(item)
    }
    
}
