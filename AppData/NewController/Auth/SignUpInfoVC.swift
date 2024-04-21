//
//  SignUpInfoVC.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class SignUpInfoVC: BaseVC {
    
    @IBOutlet var vTop: UIView!
    var store = PStore()
    @IBOutlet var tableView: UITableView!
    var trangThaiSua: Int = 0
    var img64QR: String = ""
    var img64Logo: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        vTop.addCornerRadiusToBottom(radius: 10.0)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "SingUpInfoCell")
        
    }
    func bindData(item: PStore){
        store =  item
        trangThaiSua = 0
        
    }
    
    func bindDataSua(item: PStore){
        store =  item
        trangThaiSua = 1
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    func updateStore(){
        
        store.sign()
        ServiceManager.common.updateUser(param: self.store){
            (response) in
            self.hideLoading()
            if response?.statusCode == 200 {
                CacheManager.share.setRegister(true)
                Common.userMaster = self.store
                self.showAlert(message: "Thành công!")
            } else {
                self.showAlert(message: "Lỗi thêm mới")
            }
        }
    }
}

extension SignUpInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SingUpInfoCell", for: indexPath) as? SingUpInfoCell else  {return UITableViewCell()}
        cell.presentingViewController = self  // Set the presenting view controller

        cell.actionXacNhan = {
            [weak self] item in
            guard let self = self else {return}
            
            if trangThaiSua == 1 {
                self.store.name_own = item.name_own
                self.store.storeName = item.storeName
                self.store.phone = item.phone
                self.store.address = item.address
                
                self.updateStore();
            }else {
                self.store.name_own = item.name_own
                self.store.storeName = item.storeName
                self.store.address = item.address
                self.store.phone = item.phone
                ServiceManager.common.createUser(param: self.store){
                    (response) in
                    self.hideLoading()
                    if response?.statusCode == 200 {
                        CacheManager.share.setRegister(true)
                        let vc = LoginVC()
                        vc.bindData(item: self.store)
                        self.showAlert(message: "Thành công!")
                        self.pushVC(controller: vc)
                    } else {
                        self.showAlert(message: "Lỗi thêm mới")
                    }
                }
            }
            
            
        }
        
        cell.actionChonQR = {
            self.showAlert(message: "Đang mở thư viện ảnh!")
        }
        cell.actionChonLogo = {
            self.showAlert(message: "Đang mở thư viện ảnh!")
        }
        
        cell.passImg64QR = {
            [weak self] img64 in
            guard let self = self else {return}
            self.img64QR = img64
            uploadImage(img64 : img64,stt: 1)
        }
        
        cell.passImg64Logo = {
            [weak self] img64 in
            guard let self = self else {return}
            self.img64Logo = img64
            uploadImage(img64 : img64,stt: 2)
            
        }
        
        cell.bindData(item: store)
        return cell
    }
    func uploadImage(img64: String, stt: Int){
        
        let base64String: String = img64

        let anhSanPham = FPramUploadImage()
        anhSanPham.user_id = Common.userMaster.id
        anhSanPham.base64Image = base64String

        if stt == 1 {
            ServiceManager.common.taiAnhQR(param: anhSanPham){
                (response) in
                if response?.data != nil, response?.statusCode == 200 {
                    self.showAlert(message: "Thành công!")
                    
    //                self.uploadThanhCong?(response?.data as! String)
    //                self.onBackNav(animated: false)
                } else if response?.statusCode == 0 {
    //                print("Loi")
                    self.showAlert(message: "Lỗi!")
    //                self.lbMess.isHidden = false
    //                self.lbMess.text = "Không thể tải ảnh lên lúc này, ảnh mặc định sẽ hiển thị thay thể, chọn dấu x để bỏ qua bước này"
                }
            }
        }
        if stt == 2 {
            ServiceManager.common.taiAnhLogo(param: anhSanPham){
                (response) in
                if response?.data != nil, response?.statusCode == 200 {
                    self.showAlert(message: "Thành công!")
                    
    //                self.uploadThanhCong?(response?.data as! String)
    //                self.onBackNav(animated: false)
                } else if response?.statusCode == 0 {
    //                print("Loi")
                    self.showAlert(message: "Lỗi!")
    //                self.lbMess.isHidden = false
    //                self.lbMess.text = "Không thể tải ảnh lên lúc này, ảnh mặc định sẽ hiển thị thay thể, chọn dấu x để bỏ qua bước này"
                }
            }
        }

        
    }
}
