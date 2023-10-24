//
//  KichHoatTaiKhoanVC.swift
//  LN FNB
//
//  Created by namnl on 24/10/2023.
//

import UIKit

class KichHoatTaiKhoanVC: BaseVC {

    @IBOutlet var v1: UIView!
    @IBOutlet var bXacNhan: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        v1.layer.cornerRadius = C.CornerRadius.corner5
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner5
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func xacNhanPressed(_ sender: Any) {
    }
    
    
    
}
