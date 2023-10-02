//
//  BanCell.swift
//  LN FNB
//
//  Created by namnl on 29/09/2023.
//

import UIKit

class BanCell: UITableViewCell {

    @IBOutlet weak var lbTableName: UILabel!
    var actionEdit: ClosureCustom<FTable>?
    var actionDelete: ClosureCustom<FTable>?
    @IBOutlet var bDelete: UIButton!
    @IBOutlet var bEdit: UIButton!
    var item = FTable()
    override func awakeFromNib() {
        super.awakeFromNib()
        bEdit.layer.cornerRadius = C.CornerRadius.corner5
        bDelete.layer.cornerRadius = C.CornerRadius.corner5
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
