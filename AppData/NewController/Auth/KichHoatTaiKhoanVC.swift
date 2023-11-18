//
//  KichHoatTaiKhoanVC.swift
//  LN FNB
//
//  Created by namnl on 24/10/2023.
//

import UIKit

class KichHoatTaiKhoanVC: BaseVC {

    var actionThanhCong: ClosureAction?
    @IBOutlet var lbBaoLoi: UILabel!
    @IBOutlet var lbMess: UILabel!
    @IBOutlet var tfOtp: UITextField!
    @IBOutlet var v1: UIView!
    @IBOutlet var bXacNhan: UIButton!
    var email: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        v1.layer.cornerRadius = C.CornerRadius.corner10
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner10
        lbMess.text = "Mã xác nhận được gửi đến email: \(email)"
    }
    func bindData(email: String){
        self.email = email
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func xacNhanPressed(_ sender: Any) {
        guard let otp = tfOtp.text, otp.count == 6  else {
            lbBaoLoi.isHidden = false
            lbBaoLoi.text = "Mã OTP 6 số không đúng"
            return}
        verifyUser(otp: otp)
    }
    func verifyUser(otp: String){
        let store = PStore()
        store.otp = otp
        store.email = email

        ServiceManager.common.verifyUser(param: store){
            (response) in
            self.hideLoading()
            if response?.statusCode == 200 {
                self.onBackNav()
                self.actionThanhCong?()
                
            } else {
                self.lbBaoLoi.text = "Mã OTP 6 số không đúng"
            }
        }
    }
    
    
}
