//
//  MonAnCell.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class MonAnCell: UITableViewCell {

    @IBOutlet weak var vAction: UIView!
    var passData: ((FProduct,Int,Int)->Void)?
    @IBOutlet var lbCount: UILabel!
    @IBOutlet var btnCong: UIButton!
    @IBOutlet var btnTru: UIButton!
    var item: FProduct = FProduct()
    @IBOutlet var lbGia: UILabel!
    @IBOutlet var lbTenMonAn: UILabel!
    @IBOutlet var imgItem: UIImageView!
    @IBOutlet var vItem: UIView!
    
    var st: Int = 0
    var row: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func bindData(item: FProduct, st: Int, row: Int){
        self.st = st
        self.row = row
        self.item = item
        lbGia.text = "\(item.price ?? 0)".currencyFormatting() + "đ"
        lbTenMonAn.text = item.name ?? ""
        self.item.count = item.count ?? 0
        updateUICongTru()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        vItem.layer.cornerRadius = C.CornerRadius.corner10
        vAction.layer.cornerRadius = C.CornerRadius.corner10
        vAction.layer.borderColor = C.Color.NGrey?.cgColor
        vAction.layer.borderWidth = 0.2
//        imgItem.layer.borderWidth = 0.2
//        imgItem.layer.borderColor = C.Color.Navi?.cgColor
        imgItem.layer.cornerRadius = C.CornerRadius.corner10

        btnTru.addBorder(edges: [.right], color: C.Color.NGrey!, thickness: 0.2)
        btnCong.addBorder(edges: [.left], color: C.Color.NGrey!, thickness: 0.2)

        lbCount.alpha = 0.1
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
            lbCount.alpha = 0.1
            lbCount.text = "0"
            
        }else{
            lbCount.alpha = 1
            lbCount.text = "\(item.count ?? 0)"
        }
        passData?(item,st,row)
    }
    
}
