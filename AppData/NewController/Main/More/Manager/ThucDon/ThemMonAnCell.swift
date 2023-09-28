//
//  ThemMonAnCell.swift
//  LN FNB
//
//  Created by namnl on 28/09/2023.
//

import UIKit

class ThemMonAnCell: UITableViewCell {

    @IBOutlet var bXacNhan: UIButton!
    @IBOutlet var V5: UIView!
    @IBOutlet var V4: UIView!
    @IBOutlet var imgMonAn: UIImageView!
    @IBOutlet var bChonAnh: UIButton!
    @IBOutlet var V3: UIView!
    @IBOutlet var V2: UIView!
    @IBOutlet var V1: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func setupUI(){
        V1.layer.cornerRadius = C.CornerRadius.corner5
        V2.layer.cornerRadius = C.CornerRadius.corner5
        V3.layer.cornerRadius = C.CornerRadius.corner5
        V4.layer.cornerRadius = C.CornerRadius.corner5
        V5.layer.cornerRadius = C.CornerRadius.corner5
        bChonAnh.layer.cornerRadius = C.CornerRadius.corner5
        imgMonAn.layer.cornerRadius = C.CornerRadius.corner5
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner5
    }
    
}
