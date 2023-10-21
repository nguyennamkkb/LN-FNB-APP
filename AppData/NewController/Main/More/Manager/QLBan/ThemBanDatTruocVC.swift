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

    
    
    @IBOutlet var tfGhiChu: UITextField!
    var actionReload: ClosureAction?
    @IBOutlet weak var dpTime: UIDatePicker!
    @IBOutlet weak var tfSoNguoi: UITextField!
    var order: FOrder = FOrder()
    @IBOutlet weak var tfTenBan: UITextField!
    var listTable: [FTable] = []
    var tableDaChon:[String] = []
    var dsTenBan:[String] = []
    @IBOutlet var v3: UIView!
    @IBOutlet var v2: UIView!
    @IBOutlet var V1: UIView!
    @IBOutlet var bXacNhan: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        getTables()
        setupUI()
    }
    func setupUI() {
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner5
        v3.layer.cornerRadius = C.CornerRadius.corner5
        v2.layer.cornerRadius = C.CornerRadius.corner5
        V1.layer.cornerRadius = C.CornerRadius.corner5
        
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
        
        let param = ParamSearch(user_id: id, status: 1, keySearch: nil)
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
        createOrder()
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
    
    
}
