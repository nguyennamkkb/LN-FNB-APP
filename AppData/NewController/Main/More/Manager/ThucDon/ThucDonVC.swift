//
//  ThucDonVC.swift
//  LN FNB
//
//  Created by namnl on 28/09/2023.
//

import UIKit
import FittedSheets

class ThucDonVC: BaseVC {
    
    @IBOutlet var v2: UIView!
    @IBOutlet var v1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        v1.layer.cornerRadius = C.CornerRadius.corner10
        v2.layer.cornerRadius = C.CornerRadius.corner10
        // Do any additional setup after loading the view.
    }
    @IBAction func backPreesed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func DanhMucPressed(_ sender: Any) {
        let vc = DanhMucMonVC()
        pushVC(controller: vc)
        
    }
    @IBAction func CacMonAnPressed(_ sender: Any) {
        let vc = MonAnVC()
        self.pushVC(controller: vc)
    }

}
