//
//  DanhMucMonVC.swift
//  LN FNB
//
//  Created by namnl on 28/09/2023.
//

import UIKit
import FittedSheets
import ObjectMapper

class DanhMucMonVC: BaseVC {
    
    
    
    let refreshControl = UIRefreshControl()
    @IBOutlet var keySearch: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var bAdd: UIButton!
    @IBOutlet var VSearch: UIView!
    var tableData = [FCategory]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "DanhMucCell")
        setupUI()
        getCategories()
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func addPressed(_ sender: Any) {
        let vc = ThemDanhMucVC()
        vc.actionOK = {
            [weak self] in
            guard let self =  self else {return}
            self.getCategories()
        }
        let sheet = SheetViewController(controller: vc, sizes: [.fixed(300)])
        self.present(sheet, animated: true)
    }
    @objc func refresh(_ sender: AnyObject) {
        getCategories()
        refreshControl.endRefreshing()
    }
    func setupUI(){
        VSearch.layer.cornerRadius = C.CornerRadius.corner10
        bAdd.layer.cornerRadius = C.CornerRadius.corner10
        
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    @IBAction func searchPressed(_ sender: Any) {
        getCategories()
    }
    func getCategories(){
        let keySearch = keySearch.text
        guard let id = Common.userMaster.id else {return}
        
        let param = ParamSearch(user_id: id, status: 1, keySearch: keySearch ?? "")
        
        ServiceManager.common.getAllCategories(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.tableData = Mapper<FCategory>().mapArray(JSONObject: response!.data ) ?? [FCategory]()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
    }
    func deleteCategory(id: Int){
        let param = ParamSearch(user_id: id)
        ServiceManager.common.deleteCategory(param: "\(id)?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
//                self.showAlert(message: "Thành công!")
                self.getCategories()
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể xoá")
            }
        }
    }
}
extension DanhMucMonVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DanhMucCell", for: indexPath) as? DanhMucCell else {return UITableViewCell()}
        
        let item = tableData.itemAtIndex(index: indexPath.row) ?? FCategory()
        cell.bindData(item: item)
        cell.actionEdit = {
            [weak self] data in
            guard let self = self else {return}
            let vc = ThemDanhMucVC()
            vc.actionOK = {
                [weak self] in
                guard let self =  self else {return}
                self.getCategories()
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
                deleteCategory(id: data.id ?? 0)
            }
            let sheet = SheetViewController(controller: vc, sizes: [.fixed(250)])
            self.present(sheet, animated: true)
        }
        return cell
    }
}

