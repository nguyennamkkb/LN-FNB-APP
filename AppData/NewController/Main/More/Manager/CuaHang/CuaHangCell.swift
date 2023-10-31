//
//  CuaHangCell.swift
//  LN FNB
//
//  Created by namnl on 30/09/2023.
//

import UIKit

class CuaHangCell: UITableViewCell {

    @IBOutlet var bXacNhan: UIButton!
    @IBOutlet var v4: UIView!
    @IBOutlet var v3: UIView!
    @IBOutlet var v2: UIView!
    @IBOutlet var v1: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
       setupUI()
    }
    func setupUI() {
        v4.layer.cornerRadius = C.CornerRadius.corner10
        v3.layer.cornerRadius = C.CornerRadius.corner10
        v2.layer.cornerRadius = C.CornerRadius.corner10
        v1.layer.cornerRadius = C.CornerRadius.corner10
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner10
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
