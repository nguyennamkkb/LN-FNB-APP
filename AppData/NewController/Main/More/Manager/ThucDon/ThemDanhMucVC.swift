//
//  ThemDanhMucVC.swift
//  LN FNB
//
//  Created by namnl on 28/09/2023.
//

import UIKit

class ThemDanhMucVC: ViewController {

    @IBOutlet var bXacNhan: UIButton!
    @IBOutlet var VTFDanhMuc: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        VTFDanhMuc.layer.cornerRadius = C.CornerRadius.corner5
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner5
    }
    

}
