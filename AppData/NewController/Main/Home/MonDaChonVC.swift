//
//  MonDaChonVC.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class MonDaChonVC: BaseVC {

    var tableData: [FProduct] = []
    var soNguoi: Int?
    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnXacNhan: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "MonDaChonCell")
        setupUI()
        
    }
    func bindData(list: [FProduct], soNguoi: Int){
        self.tableData = list
        self.soNguoi = soNguoi
        print(list.toJSON())
    }
    func setupUI(){
        btnXacNhan.layer.cornerRadius = C.CornerRadius.corner5
    }
    @IBAction func xacNhanPressed(_ sender: Any) {
        self.pushVC(controller: BanDangPhucVuVC())
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
        return cell
    }
    
    
}
