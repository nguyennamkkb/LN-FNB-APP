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
        //        tableViewHeightConstraint.constant = CGFloat(100)
        
    }
    func setupData(){
        bill.user_id = order.user_id
        bill.order_id = order.id
        bill.table = order.table
        bill.last_total = order.total
        listItem = Mapper<FProduct>().mapArray(JSONString: order.list_item ?? "") ?? [FProduct]()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func bindData(e: FOrder){
        order = e
        
    }
    @IBAction func TuyChonPressed(_ sender: Any) {
        let vc = BillActionVC()
        let sheet = SheetViewController(controller: vc, sizes: [.fixed(150)])
        vc.actionInHoaDon = {
            self.inHoaDon()
        }
        present(sheet, animated: true)
    }
    
    func inHoaDon(){
        if let tableImage = self.tableView.tableToImage() {
            let resizedImage = tableImage.resized(toWidth: 125)
            //            print(resizedImage.size.height)
            //            guard  let cgImage = resizedImage.cgImage else {
            //                return
            //            }
            
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
            <<< CommonPrint.removeVietnameseDiacritics(from: "Ban: \(order.table ?? "" )")
            <<< KVItem( "Nguoi: \(order.person!)","\(Common.getDateFormatFromMiliseonds(time: Int64(order.time ?? "0") ?? 0))")
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
            //            dummyPrinter.write(Data(receipt.data))
        }
    }
    func divideAndPrintData(data: [UInt8], chunkCount: Int) {
        let chunkSize = data.count / chunkCount
        for i in 0..<chunkCount {
            let start = i * chunkSize
            let end = min((i + 1) * chunkSize, data.count)
            let chunk = Array(data[start..<end])
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(i * 3)) {
                //                print(chunk.count)
                bluetoothPrinterManager.write(Data(chunk))
            }
        }
    }

    func setLbItem() -> String {
        var str: String = ""
        for (index,_) in listItem.enumerated() {
            str += "\n"
            str += "\(listItem[index].name!)\n"
            str += CommonPrint.NamKVItem(left: "\(listItem[index].price!)".currencyFormatting() + " x " + "\(listItem[index].count!)", right: "\(listItem[index].total ?? 0)".currencyFormatting()) + "\n"
        }
        print(str)
        return CommonPrint.removeVietnameseDiacritics(from: str)
    }
    

    
    func saveImageToPhotoLibrary(image: UIImage) {
        // Tạo một đối tượng thể hiện của thư viện ảnh
        PHPhotoLibrary.shared().performChanges {
            let request = PHAssetChangeRequest.creationRequestForAsset(from: image)
        } completionHandler: { success, error in
            if success {
                print("Hình ảnh đã được lưu vào thư viện ảnh.")
            } else {
                print("Lỗi khi lưu hình ảnh: \(error?.localizedDescription ?? "Lỗi không xác định")")
            }
        }
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
