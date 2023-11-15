//
//  BaoCaoHomNayCell.swift
//  LN FNB
//
//  Created by namnl on 14/11/2023.
//

import UIKit


class BaoCaoHomNayCell: UITableViewCell {

    
    
    var item = FThongKeHomNay()
    @IBOutlet var lbTNTongSoKhach: UILabel!
    @IBOutlet var lbTNTongHoaDon: UILabel!
    @IBOutlet var lbTNTongCK: UILabel!
    @IBOutlet var lbTNTongTienMat: UILabel!
    @IBOutlet var lbTNTongDoanhThu: UILabel!
    @IBOutlet var lbTheoNgayNgay: UILabel!
    
    @IBOutlet var lbTongKhach: UILabel!
    @IBOutlet var lbTongHoaDon: UILabel!
    @IBOutlet var lbThuCK: UILabel!
    @IBOutlet var lbThuTienMat: UILabel!
    @IBOutlet var lbDoanhThu: UILabel!
    @IBOutlet var lbThuDuTinh: UILabel!
    @IBOutlet var lbSoKhach: UILabel!
    @IBOutlet var lbChuaDen: UILabel!
    @IBOutlet var lbShip: UILabel!
    @IBOutlet var lbAnTaiBan: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    func bindData(e: FThongKeHomNay){
        item = e
        lbAnTaiBan.text = "\(item.chuaHoanThanh?.tongDangPhucVu ?? 0)"
        lbShip.text = "\(item.chuaHoanThanh?.tongShip ?? 0)"
        lbChuaDen.text = "\(item.chuaHoanThanh?.tongDatTruoc ?? 0)"
        lbSoKhach.text = "\(item.chuaHoanThanh?.tongKhach ?? 0)"
        
        lbTNTongDoanhThu.text = "\((item.daHoanThanh?.tongTienCK ?? 0)  + (item.daHoanThanh?.tongTienMat ?? 0 ))"
        lbTNTongTienMat.text = "\(item.daHoanThanh?.tongTienMat ?? 0 )"
        lbTNTongCK.text = "\(item.daHoanThanh?.tongTienCK ?? 0 )"
        lbTNTongHoaDon.text = "\(item.daHoanThanh?.tongSoDonHang ?? 0 )"
        lbTNTongSoKhach.text = "\(item.daHoanThanh?.tongSoKhach ?? 0 )"
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
