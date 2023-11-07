//
//  InPhieuBepVC.swift
//  LN FNB
//
//  Created by namnl on 27/09/2023.
//

import UIKit
import Printer

class InPhieuBepVC: BaseVC {
    
    
    
    @IBOutlet weak var bInPhieuBep: UIButton!
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
//            print(index)
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
        bInPhieuBep.layer.cornerRadius = C.CornerRadius.corner10
        VLabel.layer.borderWidth = 1
        VLabel.layer.borderColor = C.Color.Gray?.cgColor
    }
    @IBAction func touchPrint(sender: UIButton) {

        let vc = AlertVC()
        vc.bindData(s: "Đang in phiếu bếp")
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)


        let receipt = Receipt(.init(maxWidthDensity: 380 , fontDensity: 12, encoding: .utf8))
        
        <<~ .style(.initialize)
        <<~ .page(.printAndFeed(lines: 0))
        <<~ .layout(.justification(.center))
        <<~ .layout(.lineSpace(.l1_8))
        <<< CommonPrint.removeVietnameseDiacritics(from: "PHIEU BEP")
        <<~ .page(.printAndFeed(lines: 1))
        <<~ .layout(.justification(.left))
        <<< CommonPrint.removeVietnameseDiacritics(from:  tenNBan)
        <<< CommonPrint.removeVietnameseDiacritics(from: "Gio: " + gioIn)
    
        <<< Dividing.`default`()
        <<< KVItem("Mon", "So luong")
        <<< setLbItem()
        <<< Dividing.`default`()
        	
        <<~ .layout(.justification(.center))
        <<~ .page(.printAndFeed(lines: 1))
        <<< CommonPrint.removeVietnameseDiacritics(from: "Ung dung LN FnB")
        <<~ .cursor(.lineFeed)
        <<< Command.cursor(.lineFeed)
        <<~ .cursor(.lineFeed)
        
        if bluetoothPrinterManager.canPrint {
            bluetoothPrinterManager.write(Data(receipt.data))
        }
        
        //        dummyPrinter.write(Data(receipt.data))
    }
    func setLbItem() -> String {
        var str: String = ""
        for (index,_) in listProducts.enumerated() {
            str += "\n"
            str += CommonPrint.NamKVItem(left: "\(listProducts[index].name!)", right: "\(listProducts[index].count ?? 0)") + "\n"
        }
        return CommonPrint.removeVietnameseDiacritics(from: str)
    }
}
