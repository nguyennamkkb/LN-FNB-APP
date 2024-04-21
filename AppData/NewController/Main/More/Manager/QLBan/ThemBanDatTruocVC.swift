//
//  ThemBanDatTruocVC.swift
//  LN FNB
//
//  Created by namnl on 30/09/2023.
//

import UIKit
import ObjectMapper
import RSSelectionMenu

class ThemBanDatTruocVC: BaseVC {

    
    @IBOutlet var lbTitle: UILabel!
    var tieuDe: String = "Đăt trước bàn"
    @IBOutlet var tfGhiChu: UITextField!
    var actionReload: ClosureAction?
    @IBOutlet weak var dpTime: UIDatePicker!
    @IBOutlet weak var tfSoNguoi: UITextField!
    var order: FOrder = FOrder()
    @IBOutlet weak var tfTenBan: UITextField!
    var listTable: [FTable] = []
    var tableDaChon:[String] = []
    var dsTenBan:[String] = []
    @IBOutlet var v4: UIView!
    @IBOutlet var v3: UIView!
    @IBOutlet var v2: UIView!
    @IBOutlet var V1: UIView!
    @IBOutlet var bXacNhan: UIButton!
    
    
    var trangThaiCapNhat: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        getTables()
        setupUI()
        
        lbTitle.text = tieuDe
        setupData()
    }
    func setupData(){
        tfSoNguoi.text = "\(order.person ?? 5)"
        tfGhiChu.text = "\(order.note ?? "")"
        tfTenBan.text = "\(order.table ?? "")"
        if order.time != nil {
            let date = Date(timeIntervalSince1970: (Double(order.time ?? "0") ?? 1000) / 1000)
            dpTime.date = date
        }
       
    }
    func setupUI() {
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner10
        v4.layer.cornerRadius = C.CornerRadius.corner10
        v3.layer.cornerRadius = C.CornerRadius.corner10
        v2.layer.cornerRadius = C.CornerRadius.corner10
        V1.layer.cornerRadius = C.CornerRadius.corner10
    }
    func bindDataUpdate(e: FOrder){
        order = e
        trangThaiCapNhat = 1
        tieuDe = "Sửa đăt trước bàn"
    }
    @IBAction func chonBanTrongPressed(_ sender: Any) {
        let selectionMenu = RSSelectionMenu(selectionStyle: .multiple, dataSource: dsTenBan) { (cell, name, indexPath) in
            cell.textLabel?.text = name
            cell.tintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
        selectionMenu.show(style: .popover(sourceView: sender as! UIView, size: CGSize(width: 200, height: 300)), from: self)
        selectionMenu.onDismiss = { [weak self] selectedItems in
            self?.tfTenBan.text = selectedItems.joined(separator: " ")
            
        }
    }
    func getTables(){
        guard let id = Common.userMaster.id else {return}
        
        let param = ParamSearch(user_id: id, keySearch: nil)
        ServiceManager.common.getAllTables(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.listTable = Mapper<FTable>().mapArray(JSONObject: response!.data ) ?? [FTable]()
                for e in self.listTable {
                    self.dsTenBan.append(e.name ?? "")
                }
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể tải danh sách bàn")
            }
        }
    }
    @IBAction func xacNhanThemDatBanPressed(_ sender: Any) {
        order.user_id = Common.userMaster.id
        guard let table = tfTenBan.text else {return}
        guard let person = tfSoNguoi.text else {return}
        guard let note = tfGhiChu.text else {return}
        order.table = table
        order.person = Int(person)
        order.total = 0
        order.status = 2
        order.note = note
        order.time = "\(dpTime.date.millisecondsSince1970)"
        if trangThaiCapNhat == 1 {
            updateOrder()
        }else {
            createOrder()
        }
        
    }
    func createOrder(){
        self.showLoading()
        order.sign()
        ServiceManager.common.createDatTruoc(param: order){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.showAlert(message: "Thành công!")
                self.actionReload?()
                self.onBackNav()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
    }
    func updateOrder(){
        self.showLoading()
        order.sign()
        ServiceManager.common.updateOrder(param: order){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.showAlert(message: "Thành công!")
                self.actionReload?()
                self.onBackNav()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
    }
    
    
}
