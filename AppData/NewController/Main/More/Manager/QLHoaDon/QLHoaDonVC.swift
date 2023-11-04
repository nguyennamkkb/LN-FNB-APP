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

    var actionFilter: ClosureAction?
    @IBOutlet var tableView: UITableView!
    var tableData: [FBill] = []
    @IBOutlet var vFilter: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "HoaDonCell")
        vFilter.layer.cornerRadius = C.CornerRadius.corner10
        getHoaDons()
    }
    func getHoaDons(){
      
        guard let id = Common.userMaster.id else {return}
        let param = ParamSearch(user_id: id, status: 1)
        
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
        let sheet = SheetViewController(controller: vc, sizes: [.fixed(250)])
        self.present(sheet, animated: true)
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
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
        return cell
    }
    
    
}
