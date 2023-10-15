//
//  BanDatTruocCell.swift
//  LN FNB
//
//  Created by namnl on 29/09/2023.
//

import UIKit

class BanDatTruocCell: UITableViewCell {
    
    
    var item: FOrder  = FOrder()
    @IBOutlet weak var lbSoNguoi: UILabel!
    @IBOutlet weak var lbThoiGIanDen: UILabel!
    @IBOutlet weak var lbTenBan: UILabel!
    var actionDelete: ClosureCustom<FOrder>?
    @IBOutlet var bDelete: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        bDelete.layer.cornerRadius = C.CornerRadius.corner5
    }
    func binđata(e: FOrder){
        item = e
        lbTenBan.text = "Bàn: " + (item.table ?? "")
        lbSoNguoi.text = "\(item.person ?? 0)"
        print(item.toJSON())
        lbThoiGIanDen.text = "\(Common.getDateFormatFromMiliseonds(time:Int64(item.time ?? "0") ?? 0))"
    }
    @IBAction func deletePressed(_ sender: Any) {
        actionDelete?(item)
    }
    
}
