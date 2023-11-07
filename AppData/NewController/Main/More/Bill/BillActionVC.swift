//
//  BillActionVC.swift
//  LN FNB
//
//  Created by namnl on 05/11/2023.
//

import UIKit

class BillActionVC: BaseVC {

    @IBOutlet weak var bNganHang: UIButton!
    @IBOutlet weak var bTienMat: UIButton!
    var actionTienMat: ClosureAction?
    var actionNganHang: ClosureAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bNganHang.layer.cornerRadius = C.CornerRadius.corner10
        bTienMat.layer.cornerRadius = C.CornerRadius.corner10
        // Do any additional setup after loading the view.
    }
    @IBAction func tienMatPressed(_ sender: Any) {
        actionTienMat?()
        self.onBackNav()
    }
    @IBAction func nganHangPressed(_ sender: Any) {
        actionNganHang?()
        self.onBackNav()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
