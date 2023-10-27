//
//  SignUpVC.swift
//  LN FNB
//
//  Created by namnl on 16/09/2023.
//

import UIKit

class SignUpVC: BaseVC {

    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet var btnXacNhan: UIButton!
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        view1.layer.cornerRadius = C.CornerRadius.corner10
        view2.layer.cornerRadius = C .CornerRadius.corner10
        btnXacNhan.layer.cornerRadius = C.CornerRadius.corner10
        lbMessage.isHidden = true
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func tieptucPressed(_ sender: Any) {
//        self.pushVC(controller: SignUpInfoVC())
        view.endEditing(true)
        guard let email = tfEmail.text else {return}
        guard let password = tfPassword.text, password.count >= 6 else {return}
        self.showLoading()
        
        let store = PStore(email:email,password: password)
        ServiceManager.common.checkUser(param: store){
            (response) in
            self.hideLoading()
            if response?.statusCode == 200 {
                let vc = SignUpInfoVC()
                vc.bindData(item: store)
                self.pushVC(controller: vc)
            } else {
                self.lbMessage.isHidden = false
                self.lbMessage.text = "Thông báo: Lỗi đăng ký"
            }
        }
    }


}
