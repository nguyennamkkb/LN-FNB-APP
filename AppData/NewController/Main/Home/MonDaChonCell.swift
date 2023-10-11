//
//  MonDaChonCell.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class MonDaChonCell: UITableViewCell {
    
    @IBOutlet var btnCong: UIButton!
    @IBOutlet var btnTru: UIButton!
    var passData: ClosureCustom<FProduct>?
    var item: FProduct = FProduct()
    @IBOutlet var lbCount: UILabel!
    @IBOutlet var lbPrice: UILabel!
    @IBOutlet var lbName: UILabel!
    @IBOutlet var VLine: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func bindData(item: FProduct){
        self.item = item
        setupData()
    }
    func setupData(){
        lbCount.text = "\(item.count ?? 0)"
        lbPrice.text = "\(item.price ?? 0)".currencyFormatting() + "đ"
        lbName.text = item.name ?? ""
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        btnTru.layer.cornerRadius = C.CornerRadius.corner5
        btnCong.layer.cornerRadius = C.CornerRadius.corner5
        VLine.layer.shadowOpacity = 0.5
        VLine.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    @IBAction func congPressed(_ sender: Any) {
        guard let count = item.count else {return}
        item.count = count + 1
        updateUICongTru()
    }
    
    @IBAction func truPressed(_ sender: Any) {
        guard let count = item.count else {return}
        if count > 0 {
            item.count = count - 1
        }
        updateUICongTru()
    }
    func updateUICongTru(){
        lbCount.text = "\(item.count ?? 0)"
        passData?(item)
    }
    
}
