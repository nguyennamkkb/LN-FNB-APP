//
//  LoginVC.swift
//  LN FNB
//
//  Created by namnl on 16/09/2023.
//

import UIKit

class LoginVC: BaseVC {

    @IBOutlet var btnXacNhan: UIButton!
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        view1.layer.cornerRadius = C.CornerRadius.corner5
        view2.layer.cornerRadius = C.CornerRadius.corner5
        btnXacNhan.layer.cornerRadius = C.CornerRadius.corner5
    }

    @IBAction func dangkyPressed(_ sender: Any) {
        self.pushVC(controller: SignUpVC())
    }
    @IBAction func quenMKPressed(_ sender: Any) {
        self.pushVC(controller: ForgetPasswordVC())
    }
    
    @IBAction func xacNhanPressed(_ sender: Any) {
        self.pushVC(controller: HomeVC())
    }
}
