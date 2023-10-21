//
//  BillCell.swift
//  LN FNB
//
//  Created by namnl on 17/10/2023.
//

import UIKit
import ObjectMapper

class BillCell: UITableViewCell {
    
    
    
    @IBOutlet var lbTongTien: UILabel!
    @IBOutlet var lbSoNguoi: UILabel!
    @IBOutlet var lbGio: UILabel!
    @IBOutlet var lbBan: UILabel!
    @IBOutlet var lbSoDienThoai: UILabel!
    @IBOutlet var lbDiaChi: UILabel!
    @IBOutlet var lbTenCuaHang: UILabel!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    var heightItem: Int = 70
    var order = FOrder()
    var listItem = [FProduct]()
    var bill = FBill()
    @IBOutlet var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: "BillItemCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "BillItemCell")
        
    }
    func bindData(e:FBill, o: FOrder){
        order = o
        bill = e
        listItem = Mapper<FProduct>().mapArray(JSONString: order.list_item ?? "") ?? [FProduct]()
        tableViewHeightConstraint.constant  = CGFloat(heightItem *  listItem.count)
        setupData()
    }
    
    func setupData(){
        lbTenCuaHang.text = Common.userMaster.storeName
        lbDiaChi.text = Common.userMaster.address
        lbSoDienThoai.text = Common.userMaster.phone
        lbBan.text = "Bàn: \(order.table ?? "")"
        lbSoNguoi.text = "Số người: \(order.person ?? 0)"
        lbTongTien.text = "\(order.total ?? 0)".currencyFormatting() + "đ"
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension BillCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BillItemCell", for: indexPath) as? BillItemCell else {return UITableViewCell()}
        let item  = listItem.itemAtIndex(index: indexPath.row) ?? FProduct()
        cell.bindData(e: item)
        return cell
    }
    
    
}
