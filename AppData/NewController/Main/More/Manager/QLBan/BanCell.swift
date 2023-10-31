//
//  BanCell.swift
//  LN FNB
//
//  Created by namnl on 29/09/2023.
//

import UIKit

class BanCell: UITableViewCell {

    @IBOutlet var vItem: UIView!
    @IBOutlet weak var lbTableName: UILabel!
    var actionEdit: ClosureCustom<FTable>?
    var actionDelete: ClosureCustom<FTable>?
    @IBOutlet var bDelete: UIButton!
    @IBOutlet var bEdit: UIButton!
    var item = FTable()
    override func awakeFromNib() {
        super.awakeFromNib()
        vItem.layer.cornerRadius = C.CornerRadius.corner10

        setupData()
    }
    func bindData(item: FTable){
        self.item = item
        setupData()
    }
    func setupData(){
        lbTableName.text = self.item.name ?? ""
    }
    @IBAction func editPressed(_ sender: Any) {
        actionEdit?(item)
    }
    @IBAction func deletePressed(_ sender: Any) {
        actionDelete?(item)
    }
}
