//
//  BanDangPhucVuVC.swift
//  LN FNB
//
//  Created by namnl on 24/09/2023.
//

import UIKit
import ObjectMapper

class BanDangPhucVuVC: BaseVC {
    
    
    
    
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
        btnPhieuBep.layer.cornerRadius = C.CornerRadius.corner5
    }
    @IBAction func phieuBepPressed(_ sender: Any) {
        self.pushVC(controller: PhieuBepVC())
    }
    @IBAction func ThanhToanPressed(_ sender: Any) {
        self.pushVC(controller: BillVC())
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
        return cell
    }
}
