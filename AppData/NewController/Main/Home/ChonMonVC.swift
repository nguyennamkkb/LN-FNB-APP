//
//  ChonMonVC.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit
import ObjectMapper

class ChonMonVC: BaseVC{
    
    
    var passDataThemMon: (([FProduct],Int)->Void)?
    @IBOutlet var bCart: UIButton!
    @IBOutlet var bXacNhanThemMon: UIButton!
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
    
    var trangThaiChonThemMon: Int = 0
    var banDaChon: String = ""
    var soNguoi: Int = 5
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "MonAnCell")
        setupUI()
        setupData()
        getCategories()
        
        
    }
    @IBAction func searchPressed(_ sender: Any) {
        getCategories()
    }
    
    func setupUI(){
        if trangThaiChonThemMon == 1 {
            bCart.isHidden = true
            bXacNhanThemMon.isHidden = false
        }else {
            bCart.isHidden = false
            bXacNhanThemMon.isHidden = true
        }
        
        viewSearch.layer.cornerRadius = C.CornerRadius.corner5
        lbCountCart.layer.cornerRadius = C.CornerRadius.corner5
        bXacNhanThemMon.layer.cornerRadius = C.CornerRadius.corner5
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    func setupData(){
        lbBanDaChon.text = "Bàn: \(banDaChon)"
        tfSoNguoi.text = "\(soNguoi)"
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
    
    func bindDataThemMon(listSelected: [FProduct], ban: String, soNguoi: Int){
        banDaChon = ban
        listProductSelected = listSelected
        trangThaiChonThemMon = 1
    }
    @IBAction func xacNhanThemMonPressed(_ sender: Any) {
        dismissKeyboard()
        guard let n = tfSoNguoi.text else {return}
        passDataThemMon?(listProductFinal,Int(n) ?? 5)
        self.onBackNav()

    }
    func updateTableDataThemMon(){
        if trangThaiChonThemMon == 1, tableData.count > 0{
//            print("updateTableDataThemMon")
//            print(tableData.toJSON())
            var productMap = [Int: FProduct]()

            for p in listProductSelected {
                productMap[p.id ?? 0] = p
            }
//            print(productMap)
            for e in tableData {
                for (index, product) in e.products!.enumerated() {
                    if let newProduct = productMap[product.id!] {
                        e.products![index] = newProduct
                        print(newProduct)
                    }
                }
            }
//            print(tableData.toJSON())

            updateCountCart()
        }
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
                    if self.trangThaiChonThemMon == 1 {
                        self.updateTableDataThemMon()
                    }
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
        let section = indexPath.section
        let row = indexPath.row
        let item = tableData.itemAtIndex(index: section)?.products?.itemAtIndex(index: row) ?? FProduct()
        cell.bindData(item: item,st: section,row: row )
        cell.passData = {
            [weak self] data,st,r in
            guard let self =  self else {return}
            self.tableData[st].products?[r] = data
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
