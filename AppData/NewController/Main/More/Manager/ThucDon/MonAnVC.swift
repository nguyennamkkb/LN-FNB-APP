//
//  MonAnVC.swift
//  LN FNB
//
//  Created by namnl on 28/09/2023.
//

import UIKit
import FittedSheets
import ObjectMapper

class MonAnVC: BaseVC {
    
    let refreshControl = UIRefreshControl()
    @IBOutlet var keySearch: UITextField!
    var tableData = [FProduct]()
    var listCategory = [FCategory]()
    @IBOutlet var tableView: UITableView!
    @IBOutlet var vSearch: UIView!
    @IBOutlet var bAdd: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "QLMonAnCell")
        getProducts()
        getCategories()
    }
    @IBAction func searchPressed(_ sender: Any) {
        getProducts()
    }
    @IBAction func AddPressed(_ sender: Any) {
        let vc = ThemMonAnVC()
        vc.bindData(listCategory: listCategory)
        vc.actionOK = {
            [weak self]  in
            guard let self = self else {return}
            self.showAlert(message: "Thành công")
            self.getProducts()
        }
        self.pushVC(controller: vc)
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    func setupUI(){
        vSearch.layer.cornerRadius = C.CornerRadius.corner10
        bAdd.layer.cornerRadius = C.CornerRadius.corner10
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    @objc func refresh(_ sender: AnyObject) {
        getProducts()
        refreshControl.endRefreshing()
    }
    func getProducts(){
        let keySearch = keySearch.text
        guard let id = Common.userMaster.id else {return}
        
        let param = ParamSearch(user_id: id, status: 1, keySearch: keySearch ?? "")
        
        ServiceManager.common.getAllProducts(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<FProduct>().mapArray(JSONObject: response!.data ) ?? [FProduct]()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
    }
    func deleteProduct(id: Int){
        let param = ParamSearch(user_id: id)
        ServiceManager.common.deleteProduct(param: "\(id)?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in 
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
//                self.showAlert(message: "Thành công!")
                self.getProducts()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể xoá")
            }
        }
    }
    func getCategories(){
        guard let id = Common.userMaster.id else {return}
        let param = ParamSearch(user_id: id, status: 1, keySearch: nil)
        ServiceManager.common.getAllCategories(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.listCategory = Mapper<FCategory>().mapArray(JSONObject: response!.data ) ?? [FCategory]()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
              
            }
        }

    }
}
extension MonAnVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QLMonAnCell", for: indexPath) as? QLMonAnCell else {return UITableViewCell()}
        
        let item =  tableData.itemAtIndex(index: indexPath.row) ?? FProduct()
        cell.bindData(item: item)
        cell.actionEdit = {
            [weak self] data in
            guard let self = self else {return}
            let vc = ThemMonAnVC()
            vc.bindDataSua(item: data, trangThai: 2,listCategory: self.listCategory)
            vc.actionOK = {
                self.getProducts()
                self.showAlert(message: "Thành công")
            }
            self.pushVC(controller: vc)
        }
        cell.actionDelete = {
            [weak self] data in
            guard let self = self else {return}
            let vc = MessageVC()
            vc.actionOK  = {
                [weak self]  in
                guard let self = self else {return}
                deleteProduct(id: data.id ?? 0)
            }
            let sheet = SheetViewController(controller: vc, sizes: [.fixed(250)])
            self.present(sheet, animated: true)
        }
        
        return cell
    }
}

