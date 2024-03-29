//
//  DSDangPhucVuVC.swift
//  LN FNB
//
//  Created by namnl on 28/09/2023.
//

import UIKit
import ObjectMapper

class DSDangPhucVuVC: BaseVC {

    
    @IBOutlet weak var bCapNhat: UIButton!
    let refreshControl = UIRefreshControl()
    var tableData: [FOrder] = []
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "BanDangPhucVuCell")
        getOrders()
        
        setupUI()
    }
    func setupUI(){
        bCapNhat.layer.cornerRadius = C.CornerRadius.corner10
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    @IBAction func capNhatPressed(_ sender: Any) {
        self.showLoading()
        getOrders()
        self.hideLoading()
    }
    @objc func refresh(_ sender: AnyObject) {
        getOrders()
        refreshControl.endRefreshing()
    }
    func getOrders(){
        guard let id = Common.userMaster.id else {return}
        let param = ParamSearch(user_id: id,status: 1)
        ServiceManager.common.getAllOrder(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<FOrder>().mapArray(JSONObject: response!.data ) ?? [FOrder]()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
            
        }
    }


}
extension DSDangPhucVuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BanDangPhucVuCell", for: indexPath) as? BanDangPhucVuCell else {return UITableViewCell()}
        let item =  tableData.itemAtIndex(index: indexPath.row) ?? FOrder()
        cell.bindData(e : item)
        cell.actionChon = {
            let vc = BanDangPhucVuVC()
            vc.bindData(e: item)
            vc.actionReload = {
                self.getOrders()
            }
            self.pushVC(controller: vc)
        }
        return cell
    }
}
