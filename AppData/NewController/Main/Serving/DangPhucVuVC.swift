//
//  DangPhucVuVC.swift
//  LN FNB
//
//  Created by namnl on 18/09/2023.
//

import Printer
import UIKit
import WebKit

class DangPhucVuVC: BaseVC {

    @IBOutlet var bThuIn: UIButton!
    @IBOutlet var vDangXuat: UIView!
    @IBOutlet var vChonMayIn: UIView!
    @IBOutlet var vCuaHang: UIView!
    
    
    
    
    
    
    private let dummyPrinter =
    DummyPrinter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dummyPrinter.ticketRender = self
        bThuIn.layer.cornerRadius = C.CornerRadius.corner5
        vChonMayIn.layer.cornerRadius = C.CornerRadius.corner10
        vCuaHang.layer.cornerRadius = C.CornerRadius.corner10
        vDangXuat.layer.cornerRadius = C.CornerRadius.corner10
        
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    
    @IBAction func dangXuatPressed(_ sender: Any) {
        let vc = LoginVC()
        self.wrapRoot(vc: vc)
    }
    @IBAction func show(_ sender: Any) {
        let vc = BluetoothPrinterSelectTableViewController()
        vc.bindData(data: bluetoothPrinterManager)
        self.pushVC(controller: vc)
    }
    @IBAction func inThuPressed(_ sender: Any) {
        let vc = AlertVC()
        vc.bindData(s: "Đang in thử")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
        
        
        let receipt = Receipt(.init(maxWidthDensity: 380 , fontDensity: 12, encoding: .utf8))
        <<~ .style(.initialize)
        <<~ .page(.printAndFeed(lines: 0))
        <<~ .layout(.justification(.center))
        <<~ .layout(.lineSpace(.l1_8))
        <<< CommonPrint.removeVietnameseDiacritics(from: "IN THU")
        <<~ .page(.printAndFeed(lines: 1))
        <<< CommonPrint.removeVietnameseDiacritics(from: "Ung dung LN Quan ly nha hang")
        <<~ .cursor(.lineFeed)
        <<< Command.cursor(.lineFeed)
        <<~ .cursor(.lineFeed)
        
        if bluetoothPrinterManager.canPrint {
            bluetoothPrinterManager.write(Data(receipt.data))
        }
    }
    func printUIView(view: UIView){
        let vc = AlertVC()
        vc.bindData(s: "Đang in phiếu bếp")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
        
        let image = view.toImage()
        let resizedImage = image?.resized(toWidth: 125)
        guard  let cgImage = resizedImage?.cgImage else {
            return
        }
        
        let receipt = Receipt(.init(maxWidthDensity: 500, fontDensity: 12, encoding: .utf8))
        <<~ .style(.initialize)
        <<~ .page(.printAndFeed(lines: 0))
        <<< ImageItem(cgImage, grayThreshold: 20)
        <<~ .page(.printAndFeed(lines: 0))
        <<~ .page(.printAndFeed(lines: 0))
        if bluetoothPrinterManager.canPrint {
            bluetoothPrinterManager.write(Data(receipt.data))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BluetoothPrinterSelectTableViewController {
            vc.sectionTitle = "Chọn máy in"
            vc.printerManager = bluetoothPrinterManager
        }
    }
    
    
}

extension DangPhucVuVC: TicketRender {
    func printerDidGenerate(_ printer: DummyPrinter, html htmlTicket: String) {
//        DispatchQueue.main.async { [weak self] in
//            self?.webView.loadHTMLString(htmlTicket, baseURL: nil)
//        }
        //        debugPrint(htmlTicket)
    }
}
				
