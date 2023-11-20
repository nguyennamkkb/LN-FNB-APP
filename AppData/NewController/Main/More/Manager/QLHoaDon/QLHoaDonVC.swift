//
//  QLHoaDonVC.swift
//  LN FNB
//
//  Created by namnl on 30/09/2023.
//

import UIKit
import ObjectMapper
import FittedSheets

class QLHoaDonVC: BaseVC {
    var param = ParamSearch(status: 1)
    var actionFilter: ClosureAction?
    @IBOutlet var tableView: UITableView!
    var tableData: [FBill] = []
    var bill: FBill = FBill()
    
    var tuNgay: Int64 = Common.dateStringToMilis(dateString: Common.layThoiGianNgayThangNamHienTai(date: Date())) ?? 0
    var denNgay: Int64 = Int64(Common.getMilisecondNow())
    @IBOutlet var vFilter: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "HoaDonCell")
        vFilter.layer.cornerRadius = C.CornerRadius.corner10
        tuNgay = Common.dateStringToMilis(dateString: Common.layThoiGianNgayThangNamHienTai(date: Date())) ?? 0
        denNgay = tuNgay + 86399999
        setupData()
        getHoaDons()
    }
    func setupData(){
        param.user_id = Common.userMaster.id
        param.from = tuNgay
        param.to = denNgay
        
    }
    func getHoaDons(){
        guard let _ = Common.userMaster.id else {return}
        ServiceManager.common.getAllBill(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<FBill>().mapArray(JSONObject: response!.data ) ?? [FBill]()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
    }
    @IBAction func locPressed(_ sender: Any) {
        let vc = LocHoaDonVC()
        vc.layThoiGian = {
            [weak self] (tu,den) in
            guard let self = self else {return}
            self.param.from = tu
            self.param.to = den
            self.getHoaDons()
        }
        let sheet = SheetViewController(controller: vc, sizes: [.fixed(250)])
        self.present(sheet, animated: true)
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    func getOneBill(id: Int){
        self.showLoading()
        let param = ParamSearch(user_id: Common.userMaster.id ?? 0)
        ServiceManager.common.getOneBill(param: "\(id)?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.bill = Mapper<FBill>().map(JSONObject: response!.data ) ?? FBill()
                let vc = BillVC()
                vc.bindDataXemHD(e: self.bill)
                self.pushVC(controller: vc)
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể xoá")
            }
        }
    }


}
extension QLHoaDonVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HoaDonCell", for: indexPath) as? HoaDonCell else { return UITableViewCell()}
        let item = tableData.itemAtIndex(index: indexPath.row) ?? FBill()
        cell.bindData(e: item)
        
        cell.ActLayHoaDon = {
            [weak self] data in
            guard let self = self else {return}
            print("va0")
            self.getOneBill(id: data.id ?? 0)
            
        }
        
        return cell
    }
    
    
}
