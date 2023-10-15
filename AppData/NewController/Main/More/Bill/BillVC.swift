//
//  BillVC.swift
//  LN FNB
//
//  Created by namnl on 27/09/2023.
//

import UIKit
import FittedSheets

class BillVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func TuyChonPressed(_ sender: Any) {
        let vc = BillActionVC()
        let sheet = SheetViewController(controller: vc, sizes: [.fixed(150)])
        present(sheet, animated: true)
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
