//
//  BanDatTruocVC.swift
//  LN FNB
//
//  Created by namnl on 29/09/2023.
//

import UIKit
import FittedSheets
import ObjectMapper

class BanDatTruocVC: BaseVC {
    
    @IBOutlet weak var bCapNhat: UIButton!
    let refreshControl = UIRefreshControl()
    var actionReload: ClosureAction?
    var tableData: [FOrder] = []
    @IBOutlet var bAdd: UIButton!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "BanDatTruocCell")
        setupUI()
        getOrders()
        
    }
    
    @IBAction func bCapNhatPressed(_ sender: Any) {
        getOrders()
        self.showAlert(message: "Thành công")
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    
    func setupUI(){
        bCapNhat.layer.cornerRadius = C.CornerRadius.corner10
        bAdd.layer.cornerRadius = C.CornerRadius.corner10
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) 
    }
    @objc func refresh(_ sender: AnyObject) {
        getOrders()
        refreshControl.endRefreshing()
    }
    @IBAction func addPressed(_ sender: Any) {
        let vc = ThemBanDatTruocVC()
        let sheet = SheetViewController(controller: vc, sizes: [.fixed(520)])
        
        vc.actionReload = {
            self.getOrders()
        }
        self.present(sheet, animated: true)
    }
    func getOrders(){
       
        guard let id = Common.userMaster.id else {return}
        let param = ParamSearch(user_id: id, status: 2)
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
    func deleteOrder(idOrder: Int){
        let param = ParamSearch(user_id: Common.userMaster.id ?? 0)
        ServiceManager.common.deleteOrder(param: "\(idOrder)?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.showAlert(message: "Thành công")
                self.getOrders()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể xoá")
            }
        }
    }

}
extension BanDatTruocVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BanDatTruocCell", for: indexPath) as? BanDatTruocCell else { return UITableViewCell()}
        let item = tableData.itemAtIndex(index: indexPath.row) ?? FOrder()
        cell.binđata(e: item)
        cell.actionDelete = {
            [weak self] data in
            guard let self = self else {return}
            let vc = MessageVC()
            let sheet = SheetViewController(controller: vc, sizes: [.fixed(250)])
            self.present(sheet, animated: true)
            vc.actionOK = {
                self.deleteOrder(idOrder: data.id ?? 0)
            }
           
        }
        
        cell.actionUpdate = {
            [weak self] data in
            guard let self = self else {return}
            let vc = ThemBanDatTruocVC()
            vc.bindDataUpdate(e: data)
            vc.actionReload = {
                self.getOrders()
            }
            let sheet = SheetViewController(controller: vc, sizes: [.fixed(520)])
            self.present(sheet, animated: true)
        }
        return cell
    }
    
    
}
