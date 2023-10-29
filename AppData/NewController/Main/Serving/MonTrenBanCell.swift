//
//  MonTrenBanCell.swift
//  LN FNB
//
//  Created by namnl on 27/09/2023.
//

import UIKit

class MonTrenBanCell: UITableViewCell {

    
    
    @IBOutlet weak var vItem: UIView!
    @IBOutlet weak var vAction: UIView!
    
    
    var passData: ClosureCustom<FProduct>?
    @IBOutlet var btnTru: UIButton!
    @IBOutlet var btnCong: UIButton!
    @IBOutlet var lbCount: UILabel!
    @IBOutlet var lbGia: UILabel!
    @IBOutlet var lbName: UILabel!
    var item =  FProduct()
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
        lbCount.text = "\(item.count ?? 0)"
    }
    func setupUI(){
        vAction.layer.cornerRadius = C.CornerRadius.corner10
        vAction.layer.borderColor = C.Color.NGrey?.cgColor
        vAction.layer.borderWidth = 0.2
        vItem.layer.cornerRadius = C.CornerRadius.corner10
        btnTru.addBorder(edges: [.right], color: C.Color.NGrey!, thickness: 0.2)
        btnCong.addBorder(edges: [.left], color: C.Color.NGrey!, thickness: 0.2)
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
            
        }else{
            lbCount.alpha = 1
        }
        lbCount.text = "\(item.count ?? 0)"
        passData?(item)
    }
}
