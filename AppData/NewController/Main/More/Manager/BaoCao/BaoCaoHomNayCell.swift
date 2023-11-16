//
//  BaoCaoHomNayCell.swift
//  LN FNB
//
//  Created by namnl on 14/11/2023.
//

import UIKit


class BaoCaoHomNayCell: UITableViewCell {

    
    @IBOutlet var vTheoTungGio: UIView!
    @IBOutlet var vDaHoanThanh: UIView!
    @IBOutlet var vChuaHoanThanh: UIView!
    var actionReload: ClosureAction?
    @IBOutlet var bReload: UIButton!
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
        bReload.layer.cornerRadius = C.CornerRadius.corner10
        vChuaHoanThanh.layer.cornerRadius = C.CornerRadius.corner10
        vDaHoanThanh.layer.cornerRadius = C.CornerRadius.corner10
        vTheoTungGio.layer.cornerRadius = C.CornerRadius.corner10
        
    }
    func bindData(e: FThongKeHomNay){
        item = e
        lbAnTaiBan.text = "\(item.chuaHoanThanh?.tongDangPhucVu ?? 0)".currencyFormatting()
        lbShip.text = "\(item.chuaHoanThanh?.tongShip ?? 0)".currencyFormatting()
        lbChuaDen.text = "\(item.chuaHoanThanh?.tongDatTruoc ?? 0)".currencyFormatting()
        lbSoKhach.text = "\(item.chuaHoanThanh?.tongKhach ?? 0)".currencyFormatting()
        lbThuDuTinh.text = "\(item.chuaHoanThanh?.tongThuDuTinh ?? 0)".currencyFormatting()
        
        lbDoanhThu.text = "Doanh thu:" + "\((item.daHoanThanh?.tongTienCK ?? 0)  + (item.daHoanThanh?.tongTienMat ?? 0 ))".currencyFormatting()
        lbThuTienMat.text = "• Tiền măt: " + "\(item.daHoanThanh?.tongTienMat ?? 0 )".currencyFormatting()
        lbThuCK.text = "• Chuyển khoản: " + "\(item.daHoanThanh?.tongTienCK ?? 0 )".currencyFormatting()
        lbTongHoaDon.text = "Hoá đơn: " + "\(item.daHoanThanh?.tongSoDonHang ?? 0 )".currencyFormatting()
        lbTongKhach.text = "Số khách: " + "\(item.daHoanThanh?.tongSoKhach ?? 0 )".currencyFormatting()
                
    }
    @IBAction func reloadPressed(_ sender: Any) {
        actionReload?()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
