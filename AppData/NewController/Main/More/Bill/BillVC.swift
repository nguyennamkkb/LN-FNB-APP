//
//  BillVC.swift
//  LN FNB
//
//  Created by namnl on 27/09/2023.
//

import UIKit
import FittedSheets
import Printer
import Photos
import ObjectMapper

class BillVC: BaseVC {
    

    @IBOutlet weak var vPrint: UIView!
    @IBOutlet weak var vPay: UIView!
    
    let totalCharacterInline: Int = 31
    private let dummyPrinter = DummyPrinter()
    @IBOutlet var vBill: UIView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    var order: FOrder = FOrder()
    var bill: FBill = FBill()
    var listItem: [FProduct] = [FProduct]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerCell(nibName: "BillCell")
        setupData()
        vPrint.layer.cornerRadius = C.CornerRadius.corner10
        vPay.layer.cornerRadius = C.CornerRadius.corner10
        
    }
    func setupData(){
        bill.user_id = order.user_id
        bill.order_id = order.id
        bill.table = order.table
        bill.person = order.person
        bill.last_total = order.total
        
        bill.type = 1
        listItem = Mapper<FProduct>().mapArray(JSONString: order.list_item ?? "") ?? [FProduct]()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func bindData(e: FOrder){
        order = e
        
    }
    func updateOrder(){
        Thread.runOnBackground {
            self.order.sign()
            self.order.list_item = nil
            ServiceManager.common.ketThucOrder(param: self.order){
                (response) in
                if response?.statusCode == 200 {
                    self.showAlert(message: "Thành công")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                  
                }
            }
        }
    }
    func taoHoaDon(){
        self.bill.sign()
        self.showLoading()
        ServiceManager.common.createBill(param: bill){
            (response) in
            self.hideLoading()
            if response?.data != nil, response?.statusCode == 200 {
                self.bill = Mapper<FBill>().map(JSONObject: response!.data ) ?? FBill()
                self.updateOrder()
                
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không thể thêm mới")
            }
        }
    }
    @IBAction func thanhToanPressed(_ sender: Any) {
       
        let vc = BillActionVC()
        vc.actionTienMat = {
            [weak self] in
            guard let self = self else {return}
            self.bill.type = 1
            self.taoHoaDon()
        }
        vc.actionNganHang = {
            [weak self] in
            guard let self = self else {return}
            self.bill.type = 2
            self.taoHoaDon()
        }
        let sheet = SheetViewController(controller: vc, sizes: [.fixed(250)])
        self.present(sheet, animated: true)
    }
    
    
    @IBAction func inHoaDonPressed(_ sender: Any) {
        inHoaDon()
    }
    func inHoaDon(){
        let vc = AlertVC()
        vc.bindData(s: "Đang in hoá đơn")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
        
        let receipt = Receipt(.init(maxWidthDensity: 380 , fontDensity: 12, encoding: .utf8))
        
        <<~ .style(.initialize)
        <<~ .page(.printAndFeed(lines: 0))
        <<~ .layout(.justification(.center))
        <<< CommonPrint.removeVietnameseDiacritics(from: Common.userMaster.storeName!)
        <<< CommonPrint.removeVietnameseDiacritics(from: Common.userMaster.address!)
        <<< CommonPrint.removeVietnameseDiacritics(from: Common.userMaster.phone!)
        <<< Dividing.`default`()
        <<< CommonPrint.removeVietnameseDiacritics(from: "Thong tin dich vu")
        <<~ .page(.printAndFeed(lines: 1))
        <<~ .layout(.justification(.left))
        <<< CommonPrint.removeVietnameseDiacritics(from: bill.id == nil ? "": "Ma hd: \(bill.id ?? 0)")
        <<< CommonPrint.removeVietnameseDiacritics(from: "Ban: \(order.table ?? "" )")
        <<< KVItem( "Khach: \(order.person!)","\(Common.getDateFormatFromMiliseonds(time: Int64(((bill.timeRequest == nil) ? (order.time ?? "0") : "\(bill.timeRequest ?? 0)")) ?? 0))")
        <<< Dividing.`default`()
        <<< KVItem("Mon", "Thanh tien")
        <<< setLbItem()
        <<< Dividing.`default`()
        <<< CommonPrint.NamKVItem(left: "Tong tien", right: "\(order.total!)".currencyFormatting())
        
        <<~ .layout(.justification(.center))
        <<~ .page(.printAndFeed(lines: 1))
        <<< CommonPrint.removeVietnameseDiacritics(from: "Cam on quy khach")
        <<~ .page(.printAndFeed(lines: 1))
        <<~ .page(.printAndFeed(lines: 1))
        <<< CommonPrint.removeVietnameseDiacritics(from: "LN FnB")
        <<~ .cursor(.lineFeed)
        <<< Command.cursor(.lineFeed)
        <<~ .cursor(.lineFeed)
        
        if bluetoothPrinterManager.canPrint {
            bluetoothPrinterManager.write(Data(receipt.data))
        }
        
    }
    
    func setLbItem() -> String {
        var str: String = ""
        for (index,_) in listItem.enumerated() {
            str += "\n"
            str += "\(listItem[index].name!)\n"
            str += CommonPrint.NamKVItem(left: "\(listItem[index].price!)".currencyFormatting() + " x " + "\(listItem[index].count!)", right: "\(listItem[index].total ?? 0)".currencyFormatting()) + "\n"
        }
        return CommonPrint.removeVietnameseDiacritics(from: str)
    }
    

    
}

extension BillVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BillCell", for: indexPath) as? BillCell else {return UITableViewCell ()}
        cell.bindData(e: bill, o: order)
        return cell
    }
    
    
}
