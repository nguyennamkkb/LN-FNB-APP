//
//  TableCell.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class TableCell: UICollectionViewCell {


    var passDataSelect: ((Int,FTable)->Void)?
    var passDataDelete: ((Int,FTable)->Void)?
    var actionBanDangPhucVu: ClosureAction?
    var actionBanDaDatTruoc: ClosureAction?
    var item = FTable()
    var indexItem: Int = 0
    @IBOutlet weak var lbTableName: UILabel!
    @IBOutlet weak var imgTable: UIImageView!
    var trangThaiChon: Bool = false
    enum tableStatus: Int {
        case conTrong = 1
        case dangPhucVu = 2
        case dangGoiMon = 3
        case datTruoc = 4
        func getImage() -> UIImage {
            switch self {
            case .conTrong:
                return UIImage(named: "ic_tablett1")!
            case .dangGoiMon:
                return UIImage(named: "ic_tablett4")!
            case .dangPhucVu:
                return UIImage(named: "ic_tablett2")!
            case .datTruoc:
                return UIImage(named: "ic_tablett3")!
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func bindData(index: Int,item: FTable){
        indexItem = index
        self.item = item
        lbTableName.text = item.name
        trangThaiChon = false
        setTableImage()
    }
    func setTableImage(){
//        print("setImage", indexItem)
        
        let status: tableStatus = TableCell.tableStatus(rawValue: item.status ?? 1) ?? .conTrong
//        print("status", status)
        imgTable.image = tableStatus.getImage(status)()
    }
    @IBAction func chonBanPressed(_ sender: Any) {
        
        switch item.status {
        case 1:
            imgTable.image = tableStatus.getImage(.dangGoiMon)()
            passDataSelect?(indexItem,item)
            return
        case 3:
            imgTable.image = tableStatus.getImage(.conTrong)()
            passDataDelete?(indexItem,item)
            return
        case 2:
            actionBanDangPhucVu?()
            return
        case 4:
            actionBanDaDatTruoc?()
            return
        default:
            break
        }
        
    }
    
}

