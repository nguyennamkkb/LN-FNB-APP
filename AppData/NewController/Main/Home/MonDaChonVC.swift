//
//  MonDaChonVC.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class MonDaChonVC: BaseVC {

    
    @IBOutlet var lbSoKhach: UILabel!
    let order = FOrder()
    var table: String?
    @IBOutlet var lbTotalMoney: UILabel!
    var tableData: [FProduct] = [FProduct]()
    var soNguoi: Int? = 5
    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnXacNhan: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "MonDaChonCell")
        setupUI()
        updateMoney()
        lbSoKhach.text = "Số khách: \(soNguoi ?? 5)"
    }
    func bindData(list: [FProduct], soNguoi: Int, table: String){
        self.tableData = list
        self.soNguoi = soNguoi
        self.table = table
    }
    func setupUI(){
        btnXacNhan.layer.cornerRadius = C.CornerRadius.corner10
    }
    @IBAction func xacNhanPressed(_ sender: Any) {
        guard let personNumber = soNguoi else {return}
        guard let table = table else {return}
        if tableData.count <= 0 {return}
        let listProducts = tableData.filter {
            e in
            if e.count != 0 {
                return true
            }
            return false
        }

        order.list_item = listProducts.toJSONString()
        order.person = personNumber
        order.table = table
        order.total = getMoney()
        order.user_id =  Common.userMaster.id
        order.time =  "\(Common.getMilisecondNow())"
        order.sign()
        createOrder()
//        self.pushVC(controller: vc)
    }
    func createOrder(){
        self.showLoading()
        ServiceManager.common.createOrder(param: order){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.showAlert(message: "Thành công!")
                self.wrapRoot(vc: TabBarVC())
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
    }
    func updateMoney(){
        lbTotalMoney.text = "\(getMoney())".currencyFormatting() + "đ"
    }
    func getMoney() -> Int{
        var total: Int = 0
        for (index, e) in tableData.enumerated() {
            let money = (e.count ?? 0) * (e.price ?? 0)
            tableData[index].total = money
            total += money
        }
      return total
    }
    
}


extension MonDaChonVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MonDaChonCell", for: indexPath) as? MonDaChonCell else {return UITableViewCell()}
        let item = tableData.itemAtIndex(index: indexPath.row) ?? FProduct()
        cell.bindData(item: item)
        cell.passData = {
            [weak self] data in
            guard let self = self else {return}
            self.tableData[indexPath.row] = data
            self.updateMoney()
        }
        return cell
    }
    
    
}
