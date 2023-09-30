//
//  ThemBanDatTruocVC.swift
//  LN FNB
//
//  Created by namnl on 30/09/2023.
//

import UIKit

class ThemBanDatTruocVC: UIViewController {

    @IBOutlet var v3: UIView!
    @IBOutlet var v2: UIView!
    @IBOutlet var V1: UIView!
    @IBOutlet var bXacNhan: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    func setupUI() {
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner5
        v3.layer.cornerRadius = C.CornerRadius.corner5
        v2.layer.cornerRadius = C.CornerRadius.corner5
        V1.layer.cornerRadius = C.CornerRadius.corner5
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
