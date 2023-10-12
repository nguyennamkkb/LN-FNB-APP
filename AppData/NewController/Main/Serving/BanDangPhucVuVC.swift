//
//  BanDangPhucVuVC.swift
//  LN FNB
//
//  Created by namnl on 24/09/2023.
//

import UIKit
import ObjectMapper
import FittedSheets

class BanDangPhucVuVC: BaseVC {
    
    
    @IBOutlet var bCapNhat: UIButton!
    var actionReload: ClosureAction?
    @IBOutlet var bHuyban: UIButton!
    @IBOutlet var lbSoNguoi: UILabel!
    @IBOutlet var lbTongTien: UILabel!
    @IBOutlet var lbTitle: UILabel!
    var item = FOrder()
    var listItem = [FProduct]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnPhieuBep: UIButton!
    @IBOutlet weak var btnThanhToan: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerCell(nibName: "MonTrenBanCell")
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        setupData()
    }
    func bindData(e: FOrder){
        item = e
    }
    func setupData(){
        lbTitle.text = "Bàn: " + "\(item.table ?? "")"
        lbSoNguoi.text = "Số người: " + "\(item.person ?? 0)"
        lbTongTien.text = "Tổng tiền: " + "\(item.total ?? 0)".currencyFormatting() + "đ"
        listItem = Mapper<FProduct>().mapArray(JSONString: item.list_item ?? "") ?? [FProduct]()

        Thread.runOnMain {
            self.tableView.reloadData()
        }
    }
    func  setupUI() {
        btnThanhToan.layer.cornerRadius = C.CornerRadius.corner5
        bCapNhat.layer.cornerRadius = C.CornerRadius.corner5
        bHuyban.layer.cornerRadius = C.CornerRadius.corner5
        bCapNhat.isHidden = true
    }
    @IBAction func huyBanPressed(_ sender: Any) {
        let vc = MessageVC()
        vc.actionOK = {
            self.deleteOrder()
        }
        let sheet = SheetViewController(controller: vc, sizes: [.fixed(250)])
        self.present(sheet, animated: true)
    }
    func deleteOrder(){
        let param = ParamSearch(user_id: Common.userMaster.id ?? 0)
        ServiceManager.common.deleteOrder(param: "\(item.id ?? 0)?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.actionReload?()
                self.onBackNav()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể xoá")
            }
        }
    }
    @IBAction func phieuBepPressed(_ sender: Any) {
        self.pushVC(controller: PhieuBepVC())
    }
    @IBAction func ThanhToanPressed(_ sender: Any) {
        let vc = ActionBanDangPhucVuVC()
        vc.actionPhieuBep = {
            self.pushVC(controller: PhieuBepVC())
        }
        vc.actionThanhToan = {
            self.pushVC(controller: BillVC())
        }
        vc.actionChonThemMon = {
            self.pushVC(controller: ChonMonVC())
        }
        let sheet = SheetViewController(controller: vc, sizes: [.fixed(250)])
        self.present(sheet, animated: true)
    }
    func updateMoney(){
        lbTongTien.text = "Tổng tiền: " + "\(getMoney())".currencyFormatting() + "đ"
    }
    func getMoney() -> Int{
        var total: Int = 0
        let _ = listItem.filter{
            e in
            if e.count ?? 0 > 0 {
                let money = (e.count ?? 0) * (e.price ?? 0)
                total += money
                return true
            }
            return false
        }
      return total
    }
    func updateOrder(){
        item.list_item = listItem.toJSONString()
        item.total = getMoney()
        item.sign()
        self.showLoading()
        ServiceManager.common.updateOrder(param: item){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.actionReload?()
                self.onBackNav()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể sửa")
            }
        }
    }
    @IBAction func capNhatPressed(_ sender: Any) {
        bCapNhat.isHidden = true
        updateOrder()
    }
}
extension BanDangPhucVuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MonTrenBanCell", for: indexPath) as? MonTrenBanCell else {return UITableViewCell()}
        let e = listItem.itemAtIndex(index: indexPath.row) ?? FProduct()
        cell.bindData(e: e)
        cell.passData = {
            [weak self] data in
            guard let self = self else {return}
            listItem[indexPath.row] = data
            self.bCapNhat.isHidden = false
            self.updateMoney()
        }
        return cell
    }
}
