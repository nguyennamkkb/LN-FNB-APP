//
//  BillActionVC.swift
//  LN FNB
//
//  Created by namnl on 27/09/2023.
//

import UIKit

class BillActionVC: BaseVC {

    var actionInHoaDon: ClosureAction?
    var actionDaThanhToan: ClosureAction?
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    @IBAction func inPressed(_ sender: Any) {
        actionInHoaDon?()
        self.onBackNav()
    }
    @IBAction func daThanhToanPressed(_ sender: Any) {
        actionDaThanhToan?()
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
