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
}
