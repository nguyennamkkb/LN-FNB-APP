//
//  ChonMonVC.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit
import ObjectMapper

class ChonMonVC: BaseVC{
    
    @IBOutlet var lbCountCart: UILabel!
    var listProductSelected: [FProduct] = [FProduct]()
    var listProductFinal: [FProduct] = [FProduct]()
    @IBOutlet var tfSoNguoi: UITextField!
    let refreshControl = UIRefreshControl()
    var tableData: [FCategory] = []
    @IBOutlet var keySearch: UITextField!
    @IBOutlet var lbBanDaChon: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var viewSearch: UIView!
    var banDaChon: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "MonAnCell")
        setupUI()
        getCategories()
    }
    @IBAction func searchPressed(_ sender: Any) {
        getCategories()
    }

    func setupUI(){ 
        lbBanDaChon.text = "Bàn: \(banDaChon)"
        viewSearch.layer.cornerRadius = C.CornerRadius.corner5
        lbCountCart.layer.cornerRadius = C.CornerRadius.corner5
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    @objc func refresh(_ sender: AnyObject) {

        self.tableData.removeAll()
        getCategories()
        listProductSelected.removeAll()
          listProductFinal.removeAll()
        refreshControl.endRefreshing()
    }
    @IBAction func cartPressed(_ sender: Any) {
        dismissKeyboard()
        let vc = MonDaChonVC()
        guard let soNguoi = tfSoNguoi.text, soNguoi.count != 0, listProductFinal.count > 0  else {return}
        vc.bindData(list: listProductFinal, soNguoi: Int(soNguoi) ?? 0, table: banDaChon)
        self.pushVC(controller: vc )
    }
    func bindData(ban: String){
        banDaChon = ban
    }
    
    func getCategories(){
        dismissKeyboard()
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
    func findObject(item: FProduct) -> Bool{
        if (listProductSelected.first(where: { $0.id == item.id }) != nil) {
            // 'foundDictionary' now contains the dictionary with 'id' equal to 1
            return true
        } else {
            return false
        }
    }
    func updateCountCart(){
        dismissKeyboard()
        listProductFinal = listProductSelected.filter{
            e in
            if e.count != 0 {
                return true
            }
            return false
        }
        lbCountCart.text = "\(listProductFinal.count)"
    }
}


extension ChonMonVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0 // Adjust this value to set the desired spacing between sections
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.itemAtIndex(index: section)?.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MonAnCell", for: indexPath) as? MonAnCell else {return UITableViewCell()}
        let item = tableData.itemAtIndex(index: indexPath.section)?.products?.itemAtIndex(index: indexPath.row) ?? FProduct()
        
        cell.bindData(item: item)
        cell.passData = {
            [weak self] data in
            guard let self =  self else {return}
            if self.findObject(item: data){
                self.listProductSelected = self.listProductSelected.map{ dictionary in
                    if let id = dictionary.id, id == data.id {
                        return data
                    }
                    return dictionary
                }
            }else {
                self.listProductSelected.append(data)
            }
        
            self.updateCountCart()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Create a custom view for section headers (optional)
        let headerView = UIView()
//        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.frame.size.width, height: 30.0))
        headerView.backgroundColor = C.Color.Navi

        // Add a label for the section title
        let label = UILabel()
        label.textColor = C.Color.White
        label.font =  UIFont(name: "Roboto-Medium", size: 16)
        label.text = tableData.itemAtIndex(index: section)?.name
        label.frame = CGRect(x: 15, y: 0, width: tableView.frame.size.width, height: 30)
        headerView.addSubview(label)
        return headerView
    }
    
}
