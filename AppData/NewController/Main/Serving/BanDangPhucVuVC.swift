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
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
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
    @IBAction func MorePressed(_ sender: Any) {
        let vc = ActionBanDangPhucVuVC()
        vc.actionPhieuBep = {
            let phieuBepVC = PhieuBepVC()
            phieuBepVC.bindData(list: self.listItem, ban: self.lbTitle.text ?? "")
            self.pushVC(controller: phieuBepVC)
            
        }
        vc.actionThanhToan = {
            let billVC = BillVC()
            self.pushVC(controller: billVC)
        }
        vc.actionChonThemMon = {
            let chonMonVC = ChonMonVC()
            chonMonVC.bindDataThemMon(listSelected: self.listItem, ban: self.item.table ?? "", soNguoi: self.item.person ?? 5)
            
            chonMonVC.passDataThemMon = {
                [weak self] listProducts, n in
                guard let self = self else {return}
                self.item.list_item = listProducts.toJSONString()
                self.item.person = n
                DispatchQueue.main.async {
                   
                    self.setupData()
                    self.bCapNhat.isHidden = false
                    self.updateMoney()
                }
               
            }
            self.pushVC(controller: chonMonVC)
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
        let listProducts = listItem.filter {
            e in
            if e.count != 0 {
                return true
            }
            return false
        }
        item.list_item = listProducts.toJSONString()
        item.total = getMoney()
        item.sign()
        self.showLoading()
        ServiceManager.common.updateOrder(param: item){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.actionReload?()
                self.bCapNhat.isHidden = true
                let vc = AlertVC()
                vc.bindData(s: "Thành công")
                self.presentFullScreen(vc: vc)
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
