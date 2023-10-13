  //
//  PhieuBepVC.swift
//  LN FNB
//
//  Created by namnl on 27/09/2023.
//

import UIKit

class PhieuBepVC: BaseVC {

    var danhSachMonAn: [FProduct] = []
    @IBOutlet var lbBan: UILabel!
    @IBOutlet var lbGioTao: UILabel!
    @IBOutlet var bXacNhan: UIButton!
    @IBOutlet var tableView: UITableView!
    var tenBan: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "MonTrenBanCell")
        setupUI()
        lbBan.text = tenBan
        lbGioTao.text = Common.layThoiGianGioPhutNgayThangNam()
    }
    func setupUI(){
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner5
    }
    func bindData(list: [FProduct], ban: String){
        danhSachMonAn = list
        tenBan = ban
    }
    @IBAction func XacNhanPressed(_ sender: Any) {
        let listProducts = danhSachMonAn.filter {
            e in
            if e.count != 0 {
                return true
            }
            return false
        }
        let vc = InPhieuBepVC()
//        vc.bindData()
        self.pushVC(controller: vc)
    }
    
}
extension PhieuBepVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return danhSachMonAn.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MonTrenBanCell", for: indexPath) as? MonTrenBanCell else {return UITableViewCell()}
        let item =  danhSachMonAn.itemAtIndex(index: indexPath.row) ?? FProduct()
        cell.bindData(e: item)
        cell.passData = {
            [weak self] data in
            guard let self = self else {return}
            danhSachMonAn[indexPath.row] = data
        }
        return cell
    }
    
}
