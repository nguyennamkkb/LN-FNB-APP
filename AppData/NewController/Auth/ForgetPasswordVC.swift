//
//  ForgetPasswordVC.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class ForgetPasswordVC: BaseVC {

    @IBOutlet var bXacNhan: UIButton!
    @IBOutlet var view3: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var btnSendOtp: UIButton!
    @IBOutlet var view1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        view1.layer.cornerRadius = C.CornerRadius.corner5
        view2 .layer.cornerRadius = C.CornerRadius.corner5
        view3 .layer.cornerRadius = C.CornerRadius.corner5
        btnSendOtp.layer.cornerRadius = C.CornerRadius.corner5
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner5
    }
    @IBAction func back(_ sender: UIButton) {
        self.onBackNav()
    }
    @IBAction func xacNhanPressed(_ sender: Any) {
        self.pushVC(controller: LoginVC())
    }
    

    
}
