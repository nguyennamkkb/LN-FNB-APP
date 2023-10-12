//
//  MoreVC.swift
//  LN FNB
//
//  Created by namnl on 18/09/2023.
//

import UIKit

class MoreVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func cuaHangPressed(_ sender: Any) {
        
        let vc = CuaHangVC()
        self.pushVC(controller: vc)
    }
    @IBAction func dangXuatPressed(_ sender: Any) {
        self.wrapRoot(vc: LoginVC())
    }
    @IBAction func caiDatPressed(_ sender: Any) {
        
        self.pushVC(controller: DangPhucVuVC())
    }
    
    
    
    
    
}
