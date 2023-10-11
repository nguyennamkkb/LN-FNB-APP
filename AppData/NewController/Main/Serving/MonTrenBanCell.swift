//
//  MonTrenBanCell.swift
//  LN FNB
//
//  Created by namnl on 27/09/2023.
//

import UIKit

class MonTrenBanCell: UITableViewCell {

    @IBOutlet var lbCount: UILabel!
    @IBOutlet var lbGia: UILabel!
    @IBOutlet var lbName: UILabel!
    var item =  FProduct()
    @IBOutlet var VLine: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(e: FProduct){
        item = e
        lbGia.text = "Gia: " + "\(item.price ?? 0)".currencyFormatting() + "đ"
        lbName.text = "\(item.name ?? "")"
        lbCount.text = "\(item.cost ?? 0)"
    }
    func setupUI(){
        VLine.layer.shadowOpacity = 0.5
        VLine.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
}
