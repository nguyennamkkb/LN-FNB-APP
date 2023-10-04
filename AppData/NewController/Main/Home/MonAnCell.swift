//
//  MonAnCell.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class MonAnCell: UITableViewCell {
    
    
    var passData: ClosureCustom<FProduct>?
    @IBOutlet var lbCount: UILabel!
    @IBOutlet var btnCong: UIButton!
    @IBOutlet var btnTru: UIButton!
    var item: FProduct = FProduct()
    @IBOutlet var lbGia: UILabel!
    @IBOutlet var lbTenMonAn: UILabel!
    @IBOutlet var imgItem: UIImageView!
    @IBOutlet var VLine: UIView!
    @IBOutlet var vItem: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func bindData(item: FProduct){
        self.item = item
        lbGia.text = "\(item.price ?? 0)".currencyFormatting() + "đ"
        lbTenMonAn.text = item.name ?? ""
        self.item.count = 0
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
//        vItem.layer.cornerRadius = C.CornerRadius.corner10
        imgItem.layer.borderWidth = 0.2
        imgItem.layer.borderColor = C.Color.Navi?.cgColor
        imgItem.layer.cornerRadius = C.CornerRadius.corner5
        VLine.layer.shadowOpacity = 0.5
        VLine.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        btnTru.isHidden = true
        lbCount.isHidden = true
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
        if item.count == 0 {
            btnTru.isHidden = true
            lbCount.isHidden = true
            
        }else{
            btnTru.isHidden = false
            lbCount.isHidden = false
            lbCount.text = "\(item.count ?? 0)"
        }
        passData?(item)
    }
    
}
