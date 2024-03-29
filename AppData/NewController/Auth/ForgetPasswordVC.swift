			//
//  ForgetPasswordVC.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class ForgetPasswordVC: BaseVC {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet var tfMatKhau: UITextField!
    @IBOutlet var tfOtp: UITextField!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var lbMessage: UILabel!
    @IBOutlet var bXacNhan: UIButton!
    @IBOutlet var view3: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var btnSendOtp: UIButton!
    @IBOutlet var view1: UIView!
    var nTitle: String = "Quên mật khẩu"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        lbTitle.text = nTitle
    }
    	
    func setupUI(){
        view1.layer.cornerRadius = C.CornerRadius.corner10
        view2 .layer.cornerRadius = C.CornerRadius.corner10
        view3 .layer.cornerRadius = C.CornerRadius.corner10
        btnSendOtp.layer.cornerRadius = C.CornerRadius.corner10
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner10
        
        lbMessage.isHidden  = true
    }
    func bindDataTitle(newTitle: String){
        nTitle = newTitle
    }
    func thongBao(){
        let vc = AlertVC()
        vc.bindData(s: "Nhập email trước")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    @IBAction func guiOTPDenEmail(_ sender: Any) {
        guard let email = tfEmail.text, email.count > 5 else {
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
        guard let email = tfEmail.text, email.count > 5 else {
            lbMessage.isHidden = false
            lbMessage.text = "Nhập đủ các trường thông tin"
            return
        }
        guard let otp = tfOtp.text, otp.count == 6 else {
            lbMessage.isHidden = false
            lbMessage.text = "Nhập đủ các trường thông tin"
            return
        }
        guard let matKhau = tfMatKhau.text, matKhau.count > 0 else {
            lbMessage.isHidden = false
            lbMessage.text = "Nhập đủ các trường thông tin"
            return
        }
        let param = PStore()
        param.email = email
        param.otp = otp
        param.password = matKhau
        ServiceManager.common.verifyChangePassword(param: param){
            (response) in
            self.hideLoading()
            if response?.statusCode == 200 {
                let vc = AlertVC()
                vc.bindData(s: "Thành công")
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: false)
                vc.actionFinish = {
                    self.wrapRoot(vc: LoginVC())
                }
            } else {
                self.showAlert(message: response?.message ?? "")
            }
        }
    }
    

    
}
