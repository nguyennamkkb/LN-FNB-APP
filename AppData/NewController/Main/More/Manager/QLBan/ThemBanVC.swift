//
//  ThemBanVC.swift
//  LN FNB
//
//  Created by namnl on 29/09/2023.
//

import UIKit

class ThemBanVC: BaseVC {

    @IBOutlet var lbTitle: UILabel!
    var statusThemHoacSua: Int = 1 //1 them, 2 sua
    var sTitle: String = "Thêm bàn"
    var actionOK: ClosureAction?
    @IBOutlet weak var tfTenBan: UITextField!
    @IBOutlet var V1: UIView!
    var item =  FTable()
    @IBOutlet var bXacNhan: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        V1.layer.cornerRadius = C.CornerRadius.corner10
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner10
        setupData()
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    func bindDataSua(item: FTable, trangThai: Int) {
        self.item = item
        sTitle = "Sửa bàn"
        self.statusThemHoacSua = trangThai
        

    }
    func setupData() {
        lbTitle.text = self.sTitle
        tfTenBan.text = self.item.name ?? nil
    }
    
    @IBAction func xacNhanPressed(_ sender: Any) {
        guard let id = Common.userMaster.id else {return}
        guard let name = tfTenBan.text else {return}
        item.user_id = id
        item.name = name
        if statusThemHoacSua == 1 {
            createTable()
        }else if statusThemHoacSua == 2 {
            updateTable()
        }
       
    }
    func createTable(){
        item.sign()
        self.showLoading()
        ServiceManager.common.createTable(param: item){
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
    func updateTable(){
        item.sign()
        self.showLoading()
        ServiceManager.common.updateTable(param: item){
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
