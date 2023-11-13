//
//  MoreVC.swift
//  LN FNB
//
//  Created by namnl on 18/09/2023.
//

import UIKit

class MoreVC: BaseVC {

    
    @IBOutlet var vCaiDat: UIView!
    @IBOutlet var vLienHe: UIView!
    @IBOutlet var vBaoCao: UIView!
    @IBOutlet var vHoaDon: UIView!
    @IBOutlet var vDatTruoc: UIView!
    @IBOutlet var vQLBan: UIView!
    @IBOutlet var vMenu: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func  setupUI() {
        vMenu.layer.cornerRadius = C.CornerRadius.corner10
        vQLBan.layer.cornerRadius = C.CornerRadius.corner10
        vDatTruoc.layer.cornerRadius = C.CornerRadius.corner10
        vHoaDon.layer.cornerRadius = C.CornerRadius.corner10
        vBaoCao.layer.cornerRadius = C.CornerRadius.corner10
        vLienHe.layer.cornerRadius = C.CornerRadius.corner10
        vCaiDat.layer.cornerRadius = C.CornerRadius.corner10
    }
    @IBAction func QLThucDonPressed(_ sender: Any) {
        let vc = ThucDonVC()
        self.pushVC(controller: vc)
    }
    
    
    @IBAction func QLBanPressed(_ sender: Any) {
        let vc = QLBanVC()
        self.pushVC(controller: vc)
    }
    @IBAction func QLBanDatTruocPressed(_ sender: Any) {
        let vc = BanDatTruocVC()
        self.pushVC(controller: vc)
        
    }
    @IBAction func QLHoaDonPressed(_ sender: Any) {
        
        let vc = QLHoaDonVC()
        self.pushVC(controller: vc)
    }
//    @IBAction func cuaHangPressed(_ sender: Any) {
//
//        let vc = CuaHangVC()
//        self.pushVC(controller: vc)
//    }
//    @IBAction func dangXuatPressed(_ sender: Any) {
//        self.wrapRoot(vc: LoginVC())
//    }
//
    @IBAction func baoCaoPressed(_ sender: Any) {
        let vc = BaoCaoVC()
        self.pushVC(controller: vc)
        
    }
    
    @IBAction func caiDatPressed(_ sender: Any) {
        let vc = DangPhucVuVC()
        self.pushVC(controller: vc)
    }
    
    
    
    
    
}
