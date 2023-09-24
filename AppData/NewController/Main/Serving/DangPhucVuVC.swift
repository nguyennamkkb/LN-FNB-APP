//
//  DangPhucVuVC.swift
//  LN FNB
//
//  Created by namnl on 18/09/2023.
//

//import Printer
//import UIKit
//import CoreBluetooth
//
//
//
//class DangPhucVuVC: BaseVC,CBCentralManagerDelegate, CBPeripheralDelegate  {
//    public weak var printerManager: BluetoothPrinterManager?
//    var centralManager: CBCentralManager!
//    var printerPeripheral: CBPeripheral?
//
//    @IBOutlet var VPrint: UIView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Initialize the central manager when the view loads
//        centralManager = CBCentralManager(delegate: self, queue: nil)
//    }
//
//    // MARK: - CBCentralManagerDelegate Methods
//
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        // Check if Bluetooth is available and turned on
//        if central.state == .poweredOn {
//            // Start scanning for nearby peripherals (printers)
//            centralManager.scanForPeripherals(withServices: nil, options: nil)
//        } else {
//            // Bluetooth is not available or turned off, handle the error
//        }
//    }
//
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        // Check if the discovered peripheral is your printer (based on its name, services, etc.)
//        if peripheral.name == "MP58-01" {
//            // Stop scanning once the printer is found
//            centralManager.stopScan()
//
//            // Save the printer peripheral for later use
//            printerPeripheral = peripheral
//
//            // Connect to the printer
//            centralManager.connect(printerPeripheral!, options: nil)
//        }
//    }
//
//    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//        // Connection to the printer is successful, you can now send print commands/data
//        // Implement your print logic here
//        print("didConnect")
////        printView(VPrint)
//        sendTextToPrinter(peripheral: peripheral)
//    }
//
//    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
//        // Connection to the printer failed, handle the error
//        print("didFailToConnect")
//    }
//
//    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
//        // Handle the disconnection from the printer (if needed)
//        print("didDisconnectPeripheral")
//    }
//    func printView(_ view: UIView) {
//        // Create a print formatter for the view
//        let printFormatter = view.viewPrintFormatter()
//
//        // Create a print interaction controller
//        let printInteractionController = UIPrintInteractionController.shared
//
//        // Set the print formatter to the print interaction controller
//        printInteractionController.printFormatter = printFormatter
//
//        // If you want to customize print settings, you can do it here
//        let printInfo = UIPrintInfo(dictionary: nil)
//        printInfo.outputType = .general
//        printInfo.jobName = "MyPrintJob"
//        printInteractionController.printInfo = printInfo
//
//        // Display the print dialog
//        printInteractionController.present(animated: true, completionHandler: nil)
//    }
//    func sendTextToPrinter(peripheral: CBPeripheral) {
//        let textToPrint = "Nguyennam"
//        let deviceUUID = peripheral.identifier
//        let serviceUUID = CBUUID(string: "180F")
//        let characteristicUUID = CBUUID(string: deviceUUID.uuidString)
//        let characteristic = CBMutableCharacteristic(
//            type: characteristicUUID,
//            properties: [.read, .write, .notify], // Adjust the properties as needed
//            value: nil,
//            permissions: [.readable, .writeable]
//        )
////        let service = CBMutableService(type: serviceUUID, primary: true)
////        service.characteristics = [characteristic]
//
//
//
//        // You can convert the UUID to a string representation if needed
//
//
//        // ESC/POS command for text printing
//        let escCommandBold = "\u{1B}[1mThis text is bold.\u{1B}[0m"
//
//
//        // Convert the command to Data
//        if let data = escCommandBold.data(using: .ascii) {
//            // Send the data to the printer
////            peripheral.writeValue(data, for: characteristic, type: .withoutResponse)
////            peripheral.writeValue(data, for: characteristic)
//                printerManager.sendDataToPrinter(data)
//        }
//    }
//}
//

import Printer
import UIKit
import WebKit

class DangPhucVuVC: BaseVC {
    private let bluetoothPrinterManager = BluetoothPrinterManager()
    private let dummyPrinter = DummyPrinter()
    
    @IBOutlet var VDataPrint: UIView!
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dummyPrinter.ticketRender = self
        
    }
    @IBOutlet var mmmm: UIImageView!
    
    @IBAction func show(_ sender: Any) {
        let vc = BluetoothPrinterSelectTableViewController()
        vc.bindData(data: bluetoothPrinterManager)
        self.pushVC(controller: vc)
    }
    @IBAction func touchPrint(sender: UIButton) {
        //        guard let image = UIImage(named: "img_main"), let cgImage = image.cgImage else {
        //            return
        //        }
        let image = VDataPrint.toImage()?.resizeImage(120.0, opaque: false).convertImageToBlackAndWhite()
        guard  let cgImage = image?.cgImage else {
            return
        }
        mmmm.image = image
        let receipt = Receipt(.init(maxWidthDensity: 500, fontDensity: 12, encoding: .utf8))
        <<~ .style(.initialize)
        <<< Dividing.`default`()
        <<~ .page(.printAndFeed(lines: 0))
        ///           <<~ .page(.printAndFeed(lines: 9))
        //            <<~ .layout(.justification(.center))
        //            <<< Dividing.default()
        //            <<~ .style(.underlineMode(.enable2dot))
        <<< "Testing"
        
        <<< ImageItem(cgImage, grayThreshold: 20)
//        <<< QRCode(content: "Nguyennam",width: 50, m: .m_2)

        <<< Dividing.`default`()
        <<~ .page(.printAndFeed(lines: 0))
        //            <<< Command.cursor(.lineFeed)
        //            <<~ .cursor(.lineFeed)
        
        if bluetoothPrinterManager.canPrint {
            bluetoothPrinterManager.write(Data(receipt.data))
        }
        
//        dummyPrinter.write(Data(receipt.data))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BluetoothPrinterSelectTableViewController {
            vc.sectionTitle = "Choose Bluetooth Printer"
            vc.printerManager = bluetoothPrinterManager
        }
    }
    
    
}

extension DangPhucVuVC: TicketRender {
    func printerDidGenerate(_ printer: DummyPrinter, html htmlTicket: String) {
        DispatchQueue.main.async { [weak self] in
            self?.webView.loadHTMLString(htmlTicket, baseURL: nil)
        }
        //        debugPrint(htmlTicket)
    }
}
