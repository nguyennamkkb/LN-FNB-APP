//
//  ActionBanDangPhucVuVC.swift
//  LN FNB
//
//  Created by namnl on 13/10/2023.
//

import UIKit

class ActionBanDangPhucVuVC: BaseVC {

    var actionPhieuBep: ClosureAction?
    var actionChonThemMon: ClosureAction?
    var actionThanhToan: ClosureAction?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func chonThemMonPressed(_ sender: Any) {
        actionChonThemMon?()
        self.onBackNav()
    }
    @IBAction func inPhieuBepPressed(_ sender: Any) {
        actionPhieuBep?()
        self.onBackNav()
    }
    @IBAction func thanhToanPressed(_ sender: Any) {
        actionThanhToan?()
        self.onBackNav()
    }
}
