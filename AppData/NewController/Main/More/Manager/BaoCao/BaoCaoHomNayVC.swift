//
//  BaoCaoVC.swift
//  LN FNB
//
//  Created by namnl on 12/11/2023.
//

import UIKit
import ObjectMapper

class BaoCaoHomNayVC: BaseVC {
    
    var data: FThongKeHomNay = FThongKeHomNay()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bXemNgayKhac: UIButton!
    var timeFrom: Int64 = 0
    var timeto: Int64 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "BaoCaoHomNayCell")
        
        timeFrom = Common.dateStringToMilis(dateString: Common.layThoiGianNgayThangNamHienTai(date: Date())) ?? 0
        timeto = timeFrom + 86399999
        setupUI()
        layBaoCaoHomNay()
    }
    func setupUI(){
        bXemNgayKhac.layer.cornerRadius = C.CornerRadius.corner10
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func xemNgayKhacPressed(_ sender: Any) {
        let vc = BaoCaoTheoNgayVC()
        self.pushVC(controller: vc)
    }
    func layBaoCaoHomNay(){
        self.showLoading()
        guard let id = Common.userMaster.id else {return}
        let param = ParamSearch(user_id: id,status: 1,from: Common.dateStringToMilis(dateString: Common.layThoiGianNgayThangNamHienTai(date: Date())) ?? 0, to: Int64(Common.getMilisecondNow()))
        ServiceManager.common.taoBaoCaoHomNay(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.data = Mapper<FThongKeHomNay>().map(JSONObject: response!.data ) ?? FThongKeHomNay()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
    }
}
extension BaoCaoHomNayVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaoCaoHomNayCell", for: indexPath) as? BaoCaoHomNayCell else { return UITableViewCell()}
        cell.bindData(e: data)
        cell.actionReload = {
            self.layBaoCaoHomNay()
        }
        return cell
    }
    
    
}
