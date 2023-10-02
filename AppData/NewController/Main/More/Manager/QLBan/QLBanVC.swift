//
//  QLBanVC.swift
//  LN FNB
//
//  Created by namnl on 29/09/2023.
//

import UIKit
import FittedSheets
import ObjectMapper

class QLBanVC: BaseVC {
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var keySearch: UITextField!
    @IBOutlet weak var vSearch: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var bAdd: UIButton!
    var tableData = [FTable]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "BanCell")
        setupUI()
        getTables()
        
    }
    
    @IBAction func addPressed(_ sender: Any) {
        let vc = ThemBanVC()
        vc.actionOK = {
            [weak self] in
            guard let self =  self else {return}
            self.getTables()
        }
        let sheet = SheetViewController(controller: vc, sizes: [.fixed(300)])
        self.present(sheet, animated: true)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func searchPressed(_ sender: Any) {
        getTables()
        refreshControl.endRefreshing()
    }
    
    func setupUI() {
        bAdd.layer.cornerRadius = C.CornerRadius.corner5
        vSearch.layer.cornerRadius = C.CornerRadius.corner5
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    @objc func refresh(_ sender: AnyObject) {
        getTables()
        refreshControl.endRefreshing()
    }
    func getTables(){
        let keySearch = keySearch.text
        guard let id = Common.userMaster.id else {return}
        
        let param = ParamSearch(user_id: id, status: 1, keySearch: keySearch ?? "")
        
        ServiceManager.common.getAllTables(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<FTable>().mapArray(JSONObject: response!.data ) ?? [FTable]()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
    }
    func deleteTable(id: Int){
        let param = ParamSearch(user_id: id)
        ServiceManager.common.deleteTable(param: "\(id)?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
//                self.showAlert(message: "Thành công!")
                self.getTables()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể xoá")
            }
        }
    }
}
extension QLBanVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BanCell", for: indexPath) as? BanCell else { return UITableViewCell()}
        let item = tableData.itemAtIndex(index: indexPath.row) ?? FTable()
        cell.bindData(item: item)
        cell.actionEdit = {
            [weak self] data in
            guard let self = self else {return}
            let vc = ThemBanVC()
            vc.actionOK = {
                [weak self] in
                guard let self =  self else {return}
                self.getTables()
            }
            vc.bindDataSua(item: data, trangThai: 2)
            let sheet = SheetViewController(controller: vc, sizes: [.fixed(300)])
            self.present(sheet, animated: true)
        }
        cell.actionDelete = {
            [weak self] data in
            guard let self = self else {return}
            let vc = MessageVC()
            vc.actionOK  = {
                [weak self]  in
                guard let self = self else {return}
                deleteTable(id: data.id ?? 0)
            }
            let sheet = SheetViewController(controller: vc, sizes: [.fixed(250)])
            self.present(sheet, animated: true)
        }
        return cell
    }
    
    
}
