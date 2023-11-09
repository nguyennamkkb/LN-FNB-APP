//
//  ForgetPasswordVC.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class ForgetPasswordVC: BaseVC {

    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var lbMessage: UILabel!
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
        view1.layer.cornerRadius = C.CornerRadius.corner10
        view2 .layer.cornerRadius = C.CornerRadius.corner10
        view3 .layer.cornerRadius = C.CornerRadius.corner10
        btnSendOtp.layer.cornerRadius = C.CornerRadius.corner10
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner10
        
        lbMessage.isHidden  = true
    }
    func thongBao(){
        let vc = AlertVC()
        vc.bindData(s: "Nhập email trước")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    @IBAction func guiOTPDenEmail(_ sender: Any) {
        guard let email = tfEmail.text else {
            thongBao()
            return
        }
        let param = PStore()
        param.email = email
        ServiceManager.common.sendOtp(param: param){
            (response) in
            self.hideLoading()
            if response?.statusCode == 199 {
                let vc = AlertVC()
                vc.bindData(s: "Đã gửi OTP vào email đăng ký")
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: false)
            } else {
                self.showAlert(message: response?.message ?? "")
            }
        }
        
    }
    @IBAction func back(_ sender: UIButton) {
        self.onBackNav()
    }
    @IBAction func xacNhanPressed(_ sender: Any) {
        self.pushVC(controller: LoginVC())
    }
    

    
}
