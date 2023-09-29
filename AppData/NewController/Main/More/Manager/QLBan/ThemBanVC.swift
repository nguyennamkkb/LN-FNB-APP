//
//  ThemBanVC.swift
//  LN FNB
//
//  Created by namnl on 29/09/2023.
//

import UIKit

class ThemBanVC: BaseVC {

    @IBOutlet var V1: UIView!
    
    @IBOutlet var bXacNhan: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        V1.layer.cornerRadius = C.CornerRadius.corner5
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner5
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    

}
