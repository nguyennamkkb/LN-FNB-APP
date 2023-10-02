//
//  DanhMucCell.swift
//  LN FNB
//
//  Created by namnl on 28/09/2023.
//

import UIKit

class DanhMucCell: UITableViewCell {

    var item = FCategory()
    @IBOutlet var lbName: UILabel!
    @IBOutlet var bDelete: UIButton!
    @IBOutlet var bEdit: UIButton!
    var actionEdit: ClosureCustom<FCategory>?
    var actionDelete: ClosureCustom<FCategory>?
    override func awakeFromNib() {
        super.awakeFromNib()
        bDelete.layer.cornerRadius = C.CornerRadius.corner5
        bEdit.layer.cornerRadius = C.CornerRadius.corner5
    }

    func bindData(item: FCategory){
        self.item = item
        setupData()
    }
    func setupData(){
        lbName.text = self.item.name ?? ""
    }
    @IBAction func editPressed(_ sender: Any) {
        actionEdit?(item)
    }
    @IBAction func deletePressed(_ sender: Any) {
        actionDelete?(item)
    }
}
