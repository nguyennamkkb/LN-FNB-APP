//
//  LoginVC.swift
//  LN FNB
//
//  Created by namnl on 16/09/2023.
//

import UIKit
import ObjectMapper
import LocalAuthentication

class LoginVC: BaseVC {

    @IBOutlet weak var bAuth: UIButton!
    @IBOutlet weak var imgAuth: UIImageView!
    @IBOutlet weak var lbMessage: UILabel!
    var store = PStore()
    @IBOutlet weak var tfMatKhau: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet var btnXacNhan: UIButton!
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    func bindData(item: PStore) {
        store = item
    }
    func setupData(){
        tfEmail.text = store.email ?? "nguyennam.kkb@gmail.com"
        tfMatKhau.text = store.password ?? "123456"
    }
    func setupUI() {
        view1.layer.cornerRadius = C.CornerRadius.corner10
        view2.layer.cornerRadius = C.CornerRadius.corner10
        btnXacNhan.layer.cornerRadius = C.CornerRadius.corner10
        lbMessage.isHidden = true
        imgAuth.image = UIImage(systemName: BiometricManager.getImagetBiometric())
//        imgAuth.setImage(UIImage(systemName: BiometricManager.getImag etBiometric()), for: .normal)
    }

    @IBAction func dangkyPressed(_ sender: Any) {
        let vc = SignUpVC()
        self.pushVC(controller: vc)
    }
    @IBAction func quenMKPressed(_ sender: Any) {
        let vc = ForgetPasswordVC()
        vc.bindDataTitle(newTitle: "Quên mật khẩu")
        self.pushVC(controller: vc)
    }
    
//    @IBAction func xacNhanPressed(_ sender: Any) {
////        self.pushVC(controller: TabBarVC())
//        view.endEditing(true)
//        guard let email = tfEmail.text else {return}
//        guard let password = tfMatKhau.text else {return}
//        self.showLoading()
//        login(email: email, password: password)
//    }
    @IBAction func xacNhanPressed(_ sender: UIButton) {
        guard let email = tfEmail.text, email.count > 10  else {return}
        guard let password = tfMatKhau.text, password.count > 4  else {return}
        self.showLoading()
        login(email: email, password: password)
    }
    
    
    func login(email: String, password: String){

        let paramRequest = LoginParam(email: email, password: password)
        ServiceManager.common.signIn(param: paramRequest){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                
                CacheManager.share.setRegister(true)
                let data = Mapper<PStore>().map(JSONObject: response?.data)
                data?.password = paramRequest.password
                
                CacheManager.share.setUserMaster(value: data?.toJSONString())
                Common.userMaster = data ?? PStore()
                self.wrapRoot(vc: TabBarVC())
                
            } else if response?.data != nil, response?.statusCode == 199 {
                
                let vc = KichHoatTaiKhoanVC()
                vc.bindData(email: paramRequest.email ?? "")
                self.pushVC(controller: vc)
                
                vc.actionThanhCong = {
                    let vcAL = AlertVC()
                    vcAL.bindData(s: "Kích hoat thành công")
                    vcAL.modalPresentationStyle = .overFullScreen
                    self.present(vcAL, animated: false)
                    
                    vcAL.actionFinish = {
                        self.login(email: email, password: password)
                    }
                    
                }
                
                
                
            } else if response?.statusCode == 0 {
                self.lbMessage.isHidden = false
                self.lbMessage.text = "Thông báo: email hoặc mật khẩu không đúng"
            }
        }
    }
    @IBAction func biomatricAuthPressed(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        
        // Check if the device supports Face ID or Touch ID
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate using Face ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                DispatchQueue.main.async {
                    if success {
                        guard let pStore = Mapper<PStore>().map(JSONString: CacheManager.share.getUserMaster()) else {return}
//                        self.tfEmail.text = pStore.email
//                        self.tfMatKhau.text = pStore.password
                
                        self.login(email: pStore.email ?? "", password: pStore.password ?? "")
                        print("thanh cong")
                    } else {
                        print("That bai")
                    }
                }
            }
        } else {
            // Biometric authentication not supported
        }
    }
}
