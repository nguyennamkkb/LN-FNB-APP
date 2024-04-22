//
//  LienHeVC.swift
//  LN FNB
//
//  Created by namnl on 19/11/2023.
//

import UIKit

class LienHeVC: BaseVC{

    @IBOutlet weak var bLienHe: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        bLienHe.layer.cornerRadius = C.CornerRadius.corner10
        // Do any additional setup after loading the view.
    }

    @IBAction func dongPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func xemTrangWeb(_ sender: Any) {
        if let url = URL(string: "https://nguyenluongnam.name.vn/?p=340") {
            UIApplication.shared.open(url)
        }
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
