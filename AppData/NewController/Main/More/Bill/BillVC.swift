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

class BillVC: BaseVC {
    
    
    
    private let dummyPrinter = DummyPrinter()
    @IBOutlet var vBill: UIView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    var order: FOrder = FOrder()
    var bill: FBill = FBill()
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
            let receipt = Receipt(.init(maxWidthDensity: 500 , fontDensity: 12, encoding: .utf8))
            <<~ .style(.initialize)
            <<~ .page(.printAndFeed(lines: 0))
            <<~ .layout(.justification(.center))
            <<< removeVietnameseDiacritics(from: Common.userMaster.storeName!)
            <<< removeVietnameseDiacritics(from: Common.userMaster.address!)
            <<< removeVietnameseDiacritics(from: Common.userMaster.phone!)
            <<< removeVietnameseDiacritics(from: Common.userMaster.email!)
            <<< Dividing.`default`()
            <<< removeVietnameseDiacritics(from: "Thong tin dich vu")
//            <<< ImageItem(cgImage, grayThreshold: 24)
            <<~ .page(.printAndFeed(lines: 0))
            <<~ .page(.printAndFeed(lines: 0))

            if bluetoothPrinterManager.canPrint {
//                divideAndPrintData(data: totalBytes, chunkCount: 2)
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
    func removeVietnameseDiacritics(from input: String) -> String {
        let mutableString = NSMutableString(string: input)
        
        if CFStringTransform(mutableString, nil, kCFStringTransformStripCombiningMarks, false) {
            return mutableString as String
        }
        
        return ""
    }
    func requestPhotoLibraryAddAccess() {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                if let tableImage = self.tableView.tableToImage() {
                    //                    self.saveImageToPhotoLibrary(image: tableImage)
                    let resizedImage = tableImage.resized(toWidth: 125)
                    print(resizedImage.size.height)
                    guard  let cgImage = resizedImage.cgImage else {
                        return
                    }
                    let receipt = Receipt(.init(maxWidthDensity: 1500 , fontDensity: 12, encoding: .utf8))
                    <<~ .style(.initialize)
                    <<~ .page(.printAndFeed(lines: 0))
                    <<< ImageItem(cgImage, grayThreshold: 20)
                    <<~ .page(.printAndFeed(lines: 0))
                    <<~ .page(.printAndFeed(lines: 0))
                    if bluetoothPrinterManager.canPrint {
                        bluetoothPrinterManager.write(Data(receipt.data))
                    }
                }
            } else {
                // Xử lý trường hợp người dùng từ chối cấp quyền.
            }
        }
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
