//
//  QLMonAnCell.swift
//  LN FNB
//
//  Created by namnl on 28/09/2023.
//

import UIKit

class QLMonAnCell: UITableViewCell {

    @IBOutlet var vItem: UIView!
    @IBOutlet var lbName: UILabel!
    var item = FProduct()
    var actionEdit: ClosureCustom<FProduct>?
    var actionDelete: ClosureCustom<FProduct>?
    @IBOutlet var bDelete: UIButton!
    @IBOutlet var bEdit: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        vItem.layer.cornerRadius = C.CornerRadius.corner10

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func bindData(item: FProduct){
        self.item = item
        lbName.text = self.item.name ?? ""
    }
    
    @IBAction func editPressed(_ sender: Any) {
        actionEdit?(item)
    }
    @IBAction func deletePressed(_ sender: Any) {
        actionDelete?(item)
    }
    
}
