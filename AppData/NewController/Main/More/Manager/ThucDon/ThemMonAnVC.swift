//
//  ThemMonAnVC.swift
//  LN FNB
//
//  Created by namnl on 29/09/2023.
//

import UIKit
import ObjectMapper

class ThemMonAnVC: BaseVC {

    @IBOutlet var lbTieuDe: UILabel!
    var tieuDe: String = "Thêm món ăn"
    var listCategory = [FCategory]()
    var item = FProduct()
    var actionOK: ClosureAction?
    var trangThaiSua: Int = 1
    var trangThaiLayAnh: Int = 0
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "ThemMonAnCell")
        lbTieuDe.text = tieuDe
        
    }
    func bindData(listCategory: [FCategory]){
        self.listCategory = listCategory
    }
    func bindDataSua(item: FProduct, trangThai: Int, listCategory: [FCategory]){
        self.listCategory = listCategory
        self.item = item
        self.trangThaiSua = trangThai
        tieuDe = "Sửa món ăn"
        print("item update \(self.item.toJSON())")
    }
    
    func createProduct(){
        item.sign()
        ServiceManager.common.createProduct(param: item){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.item =  Mapper<FProduct>().map(JSONObject: response?.data) ?? FProduct()
                
                let vc = MonAnThemAnhVC()
                vc.bindData(e: self.item)
                self.pushVC(controller: vc)
                vc.uploadThanhCong = {
                    [weak self] url in
                    guard let self = self else {return}
                    self.item.image = url
                    self.trangThaiLayAnh = 1
                    self.updateProduct()
                }
                
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
    }
    func updateProduct(){
        item.sign()
        ServiceManager.common.updateProduct(param: item){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                if self.trangThaiLayAnh == 0 {
                    print("Chon anh")
                    print("item")
                    let vc = MonAnThemAnhVC()
                    vc.bindData(e: self.item)
                   
                    self.pushVC(controller: vc)
                    vc.uploadThanhCong = {
                        [weak self] url in
                        guard let self = self else {return}
                        self.item.image = url
                        self.trangThaiLayAnh = 1
                        self.updateProduct()
                    
                    }
                    vc.uploadMacDinh = {
                        [weak self] in
                        guard let self = self else {return}
                        print("ket thuc")
                        self.onBackNav(animated: false)
                    }
                }else{
                    self.actionOK?()
                    self.onBackNav(animated: false)
                }
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể sửa")
            }
        }
    }
    func taiAnhSanPham(item: FProduct){
       
    }
}
extension ThemMonAnVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThemMonAnCell", for: indexPath) as? ThemMonAnCell else {return UITableViewCell()}
        cell.bindDataCategories(list: listCategory)
        if trangThaiSua == 2 {
            cell.bindData(item: item )
        }
        
        cell.passData = {
            [weak self] data in
            guard let self = self else {return}
            self.item = data
            if trangThaiSua == 2 {
                self.updateProduct()
            }else {
                self.createProduct()
            }
            
        }

        return cell
    }
}
