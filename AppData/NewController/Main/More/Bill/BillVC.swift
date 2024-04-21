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
import CoreImage


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
    var trangThaiXemHoaDon: Int = 0
    var trangThaiHoanThanh: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
        
    }
    @IBAction func backPressed(_ sender: Any) {
        if (trangThaiHoanThanh == 0) {
            self.onBackNav()
        }else {
            self.wrapRoot(vc: TabBarVC())
        }
        
    }
    func setupUI(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerCell(nibName: "BillCell")
        vPrint.layer.cornerRadius = C.CornerRadius.corner10
        vPay.layer.cornerRadius = C.CornerRadius.corner10
        if trangThaiXemHoaDon == 1 {
            vPay.isHidden = true
        }
    }
    func bindDataXemHD(e: FBill){
        bill = e
        order = e.order ?? FOrder()
        trangThaiXemHoaDon = 1
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
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
                    
                    self.trangThaiHoanThanh = 1
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
        var trangThaiTaiAnh: Int = 0
        vc.bindData(s: "Đang in hoá đơn")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
        
        //anh qr
        let imageViewQR = UIImageView()
        var resizedImageQR = UIImage(named: "img_qn")!
        
        let url: String = ServiceManager.ROOT+"images/viewimage/qr"+String(Common.userMaster.id ?? 1)



        imageViewQR.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "img_qn"), completionHandler:  { result in
            switch result {
            case .success(_):
                trangThaiTaiAnh = 1
                print("Tai anh thanh cong")
                resizedImageQR = imageViewQR.image?.resized(toWidth: 250) ?? UIImage()
            case .failure(_):
                print("Lỗi tải ảnh")
                resizedImageQR = UIImage(named: "img_qn")!.resized(toWidth: 1)
  
            }
        })
        if trangThaiTaiAnh == 0 {
            return
        }
       
        
        
 
        guard let resizedImageQR1 = convertImageToBlackAndWhite(inputImage: resizedImageQR ) else {return}
//        guard  let cgImageQR = resizedImageQR1?.reducePixelQuality(quality: 0.9)  else {
        let cgImageQR = (resizedImageQR1.reducePixelQuality(quality: 0.5))?.cgImage!
        print("url4",url)
        
        
        
//        // anh logo
//        let imageViewLogo = UIImageView()
//        imageViewLogo.kf.setImage(with:URL(string: ServiceManager.ROOT+"images/viewimage/logo"+String(Common.userMaster.id ?? 1)))
//        let resizedImageLogo = imageViewLogo.image?.resized(toWidth: 350)
//        guard let resizedImagelogo = resizedImageLogo else{return}
//        let resizedImagelogo1 = convertImageToBlackAndWhite(inputImage: resizedImagelogo )
////        guard  let cgImageQR = resizedImageQR1?.reducePixelQuality(quality: 0.9)  else {
//        guard  let cgImageLogo = resizedImagelogo1?.reducePixelQuality(quality: 0.1)?.cgImage  else {
//            return
//        }
//        
        
        
        //ket thuc
        
        let receipt = Receipt(.init(maxWidthDensity: 380 , fontDensity: 12, encoding: .utf8))
        
        <<~ .style(.initialize)
        <<~ .page(.printAndFeed(lines: 0))
        <<~ .layout(.justification(.center))
//        <<< ImageItem(cgImageLogo, grayThreshold: 60 )
        <<< CommonPrint.removeVietnameseDiacritics(from: (Common.userMaster.storeName ?? "").uppercased())
        <<~ .page(.printAndFeed(lines: 1))
//        <<~ .page(.printAndFeed(lines: 1))
        <<< CommonPrint.removeVietnameseDiacritics(from: Common.userMaster.address!)
//        <<~ .page(.printAndFeed(lines: 1))
        <<< CommonPrint.removeVietnameseDiacritics(from: "DT: "+Common.userMaster.phone!)
        <<< Dividing.`default`()
        <<< CommonPrint.removeVietnameseDiacritics(from: "THONG TIN DICH VU")
//        <<~ .page(.printAndFeed(lines: 1))
        <<~ .layout(.justification(.left))
        <<< CommonPrint.removeVietnameseDiacritics(from: bill.id == nil ? "": "HD: #\(bill.id ?? 0)")
        <<< CommonPrint.removeVietnameseDiacritics(from: "Ban: \(order.table ?? "" )")
        <<< KVItem( "Khach: \(order.person!)","\(Common.getDateFormatFromMiliseonds(time: Int64(((bill.timeRequest == nil) ? (order.time ?? "0") : "\(bill.timeRequest ?? 0)")) ?? 0))")
        <<< Dividing.`default`()
        <<< KVItem("DV", "Thanh tien")
        <<< setLbItem()
        <<< Dividing.`default`()
        <<< CommonPrint.NamKVItem(left: "Tong tien", right: "\(order.total!)".currencyFormatting())
        <<~ .layout(.justification(.center))
        <<~ .page(.printAndFeed(lines: 1))
        <<< ImageItem(cgImageQR!, grayThreshold: 100 )
        <<< CommonPrint.removeVietnameseDiacritics(from: "Cam on quy khach!")
        <<~ .page(.printAndFeed(lines: 1))
        
        <<< CommonPrint.removeVietnameseDiacritics(from: "quetnhanh.vn")
        <<< CommonPrint.removeVietnameseDiacritics(from: "Hỗ trợ quản lý miễn phí")
        
        <<< Command.cursor(.lineFeed)
        <<~ .cursor(.lineFeed)
        
        if bluetoothPrinterManager.canPrint {
            bluetoothPrinterManager.write(Data(receipt.data))
        }
        
    }
    
    func setLbItem() -> String {
        var str: String = ""
        for (index,_) in listItem.enumerated() {
//            str += "\n"
            str += "\(listItem[index].name!)\n"
            str += CommonPrint.NamKVItem(left: "\(listItem[index].price!)".currencyFormatting() + " x " + "\(listItem[index].count!)", right: "\(listItem[index].total ?? 0)".currencyFormatting())
//            str += "\n"
        }
        return CommonPrint.removeVietnameseDiacritics(from: str)
    }
    

    
    func convertImageToBlackAndWhite(inputImage: UIImage) -> UIImage? {
        // Chuyển đổi UIImage thành CIImage
        guard let ciImage = CIImage(image: inputImage) else { return nil }
        
        // Tạo bộ lọc chuyển màu trắng thành đen và đảo ngược màu của các màu khác
        let invertedFilter = CIFilter(name: "CIColorInvert")
        invertedFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        guard let invertedOutputImage = invertedFilter?.outputImage else { return nil }
        
        // Điều chỉnh độ sáng và độ tương phản của hình ảnh
        let colorControlsFilter = CIFilter(name: "CIColorControls")
        colorControlsFilter?.setValue(invertedOutputImage, forKey: kCIInputImageKey)
        colorControlsFilter?.setValue(0.0, forKey: kCIInputBrightnessKey) // Đặt độ sáng thành 0
        colorControlsFilter?.setValue(1.0, forKey: kCIInputContrastKey) // Đặt độ tương phản thành 1
        guard let outputImage = colorControlsFilter?.outputImage else { return nil }
        
        // Tạo một ngữ cảnh đồ họa và lấy hình ảnh từ ngữ cảnh đó
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        
        // Tạo UIImage từ CGImage và trả về
        return UIImage(cgImage: cgImage)
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
