//
//  InPhieuBepVC.swift
//  LN FNB
//
//  Created by namnl on 27/09/2023.
//

import UIKit
import Printer

class InPhieuBepVC: BaseVC {
    
    
    
    @IBOutlet var lbSoLuong: UILabel!
    @IBOutlet var lbTenMon: UILabel!
    
    @IBOutlet var lbGioIn: UILabel!
    @IBOutlet var lbTenBan: UILabel!
    private let dummyPrinter = DummyPrinter()
    var tenNBan: String = ""
    var gioIn: String = ""
    @IBOutlet var VLabel: UIView!
    
    var listProducts: [FProduct] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    func bindData(list: [FProduct], ban: String, gio: String){
        listProducts = list
        tenNBan = ban
        gioIn = gio
    }
    func setupData(){
        lbGioIn.text = gioIn
        lbTenBan.text = tenNBan
        
        var s: String = ""
        var sl: String = ""
        for (index,e) in listProducts.enumerated() {
            print(index)
            if index == listProducts.count - 1{
                s +=  "\(e.name ?? "")"
                sl += "\(e.count ?? 0)"
            }else {
                s += "\(e.name ?? "")" +  "\n"
                sl += "\(e.count ?? 0)" +  "\n"
            }
        }
        
        lbTenMon.text = s
        lbSoLuong.text = sl
    }
    
    func setupUI(){
        VLabel.layer.borderWidth = 1
        VLabel.layer.borderColor = C.Color.Gray?.cgColor
    }
    @IBAction func touchPrint(sender: UIButton) {
        //        guard let image = UIImage(named: "img_main"), let cgImage = image.cgImage else {
        //            return
        //        }
        let vc = AlertVC()
        vc.bindData(s: "Đang in phiếu bếp")
        self.presentFullScreen(vc: vc)
        
        let image = VLabel.toImage()
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
        
        //        dummyPrinter.write(Data(receipt.data))
    }
}
