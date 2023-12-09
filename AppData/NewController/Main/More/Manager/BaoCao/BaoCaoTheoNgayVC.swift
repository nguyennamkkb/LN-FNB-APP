//
//  BaoCaoNgayKhacVC.swift
//  LN FNB
//
//  Created by namnl on 14/11/2023.
//

import UIKit
import ObjectMapper

class BaoCaoTheoNgayVC: BaseVC {


    var data = FThongKeTheoNgay()
    @IBOutlet var tableView: UITableView!
    var timeFrom: Int64 = 0
    var timeTo: Int64 = 0
    var strTimeTo: String = ""
    var strtimeFrom: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "BaoCaoTheoNgayCell")
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    func layBaoCaoTheoNgay(){
        self.showLoading()
        guard let id = Common.userMaster.id else {return}
        let param = ParamSearch(user_id: id,status: 1,from: timeFrom, to: timeTo)
        ServiceManager.common.taoBaoCaoTheoThoiGian(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.data = Mapper<FThongKeTheoNgay>().map(JSONObject: response!.data ) ?? FThongKeTheoNgay()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
    }

}
extension BaoCaoTheoNgayVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaoCaoTheoNgayCell", for: indexPath) as? BaoCaoTheoNgayCell else { return UITableViewCell()}
        
        cell.bindData(e: data, tu: strtimeFrom, den: strTimeTo )
        cell.layThoiGian = {
            [weak self] (tu, den, strTu, strDen) in
            guard let self = self else {return}
            self.timeFrom = tu
            self.timeTo = den
            self.strTimeTo = strDen
            self.strtimeFrom = strTu
            self.layBaoCaoTheoNgay()
        }
        return cell
    }
    
    
}
