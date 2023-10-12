//
//  TableCell.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class TableCell: UICollectionViewCell {

    @IBOutlet var imgCheck: UIImageView!
    var passDataSelect: ClosureCustom<FTable>?
    var passDataDelete: ClosureCustom<FTable>?
    var actionBanDangPhucVu: ClosureAction?
    var item = FTable()
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

    func bindData(item: FTable){
        self.item = item
        lbTableName.text = item.name
        trangThaiChon = false
        imgCheck.isHidden = true
        setTableImage()
    }
    func setTableImage(){
        let status: tableStatus = TableCell.tableStatus(rawValue: item.status ?? 1) ?? .conTrong
        imgCheck.isHidden = true
        imgTable.image = tableStatus.getImage(status)()
    }
    @IBAction func chonBanPressed(_ sender: Any) {
        
        if item.status != 1 {
            actionBanDangPhucVu?()
            return
        }
        
        if trangThaiChon == false {
            imgCheck.isHidden = false
            imgTable.image = tableStatus.getImage(.dangGoiMon)()
            passDataSelect?(item)
        }else {
            imgTable.image = tableStatus.getImage(.conTrong)()
            imgCheck.isHidden = true
            passDataDelete?(item)
        }
        trangThaiChon = !trangThaiChon
    }
    
}

