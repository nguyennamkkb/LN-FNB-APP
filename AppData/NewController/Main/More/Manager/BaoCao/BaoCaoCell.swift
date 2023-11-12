//
//  BaoCaoCell.swift
//  LN FNB
//
//  Created by namnl on 12/11/2023.
//

import UIKit

class BaoCaoCell: UITableViewCell {

    
    @IBOutlet weak var vTheoNgay: UIView!
    @IBOutlet weak var vLoaiAn: UIView!
    @IBOutlet weak var vTongQuan: UIView!
    @IBOutlet weak var tfDenNgay: UITextField!
    @IBOutlet weak var tfTuNgay: UITextField!
    @IBOutlet weak var vDenNgay: UIView!
    @IBOutlet weak var vTuNgay: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func setupUI(){
        vDenNgay.layer.cornerRadius = C.CornerRadius.corner10
        vTuNgay.layer.cornerRadius = C.CornerRadius.corner10
        vLoaiAn.layer.cornerRadius = C.CornerRadius.corner10
        vTheoNgay.layer.cornerRadius = C.CornerRadius.corner10
        vTongQuan.layer.cornerRadius = C.CornerRadius.corner10
    }
    func bindData(tuNgay: String, denNgay: String){
        tfTuNgay.text = tuNgay
        tfDenNgay.text = denNgay
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
