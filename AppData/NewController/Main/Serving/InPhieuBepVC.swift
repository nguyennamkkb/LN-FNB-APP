//
//  InPhieuBepVC.swift
//  LN FNB
//
//  Created by namnl on 27/09/2023.
//

import UIKit
import Printer

class InPhieuBepVC: BaseVC {
    private let dummyPrinter = DummyPrinter()
    @IBOutlet var VLabel: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI(){
        VLabel.layer.borderWidth = 1
        VLabel.layer.borderColor = C.Color.Gray?.cgColor
    }
    @IBAction func touchPrint(sender: UIButton) {
        //        guard let image = UIImage(named: "img_main"), let cgImage = image.cgImage else {
        //            return
        //        }
        let image = VLabel.toImage()?.resizeImage(125.0, opaque: false).convertImageToBlackAndWhite()
        guard  let cgImage = image?.cgImage else {
            return
        }

        let receipt = Receipt(.init(maxWidthDensity: 500, fontDensity: 12, encoding: .utf8))
        <<~ .style(.initialize)
        <<~ .page(.printAndFeed(lines: 0))
        ///           <<~ .page(.printAndFeed(lines: 9))
        //            <<~ .layout(.justification(.center))
        //            <<< Dividing.default()
        //            <<~ .style(.underlineMode(.enable2dot))
        
        <<< ImageItem(cgImage, grayThreshold: 20)
//        <<< Dividing.`default`()
        <<~ .page(.printAndFeed(lines: 0))
        <<~ .page(.printAndFeed(lines: 0))
        if bluetoothPrinterManager.canPrint {
            bluetoothPrinterManager.write(Data(receipt.data))
        }
        
        dummyPrinter.write(Data(receipt.data))
    }
}
