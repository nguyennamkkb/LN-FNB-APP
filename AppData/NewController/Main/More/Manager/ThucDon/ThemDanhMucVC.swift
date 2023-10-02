//
//  ThemDanhMucVC.swift
//  LN FNB
//
//  Created by namnl on 28/09/2023.
//

import UIKit

class ThemDanhMucVC: BaseVC {

    var statusThemHoacSua: Int = 1 //1 them, 2 sua
    var item = FCategory()
    var actionOK: ClosureAction?
    @IBOutlet var tfDanhMuc: UITextField!
    @IBOutlet var bXacNhan: UIButton!
    @IBOutlet var VTFDanhMuc: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        VTFDanhMuc.layer.cornerRadius = C.CornerRadius.corner5
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner5
        setupData()
    }
    @IBAction func xacNhanPressed(_ sender: Any) {
        guard let id = Common.userMaster.id else {return}
        guard let name = tfDanhMuc.text else {return}
        item.user_id = id
        item.name = name
        if statusThemHoacSua == 1 {
            createCategory()
        }else if statusThemHoacSua == 2 {
            updateCategory()
        }
    }
    func bindDataSua(item: FCategory, trangThai: Int){
        self.item = item
        statusThemHoacSua = trangThai
    }
    func setupData() {
        tfDanhMuc.text = self.item.name ?? nil
    }
    func createCategory(){
        item.sign()
        self.showLoading()
        ServiceManager.common.createCategory(param: item){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.showAlert(message: "Thành công!")
                self.actionOK?()
                self.onBackNav()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
    }
    func updateCategory(){
        item.sign()
        self.showLoading()
        ServiceManager.common.updateCategory(param: item){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.showAlert(message: "Thành công!")
                self.actionOK?()
                self.onBackNav()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể sửa")
            }
        }
    }

}
