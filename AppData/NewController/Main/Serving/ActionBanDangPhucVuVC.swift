//
//  ActionBanDangPhucVuVC.swift
//  LN FNB
//
//  Created by namnl on 13/10/2023.
//

import UIKit

class ActionBanDangPhucVuVC: BaseVC {

    
    @IBOutlet weak var v4: UIView!
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v1: UIView!
    var actionPhieuBep: ClosureAction?
    var actionDelete: ClosureAction?
    var actionChonThemMon: ClosureAction?
    var actionThanhToan: ClosureAction?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    func setupUI(){
        v1.layer.cornerRadius = C.CornerRadius.corner10
        v2.layer.cornerRadius = C.CornerRadius.corner10
        v3.layer.cornerRadius = C.CornerRadius.corner10
        v4.layer.cornerRadius = C.CornerRadius.corner10
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
    @IBAction func huyBanPressed(_ sender: Any) {
        self.onBackNav()
        actionDelete?()
        
    }
    
}
