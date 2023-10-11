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
    var item = FTable()
    @IBOutlet weak var lbTableName: UILabel!
    @IBOutlet weak var imgTable: UIImageView!
    var trangThaiChon: Bool = false
    enum tableStatus: Int {
        case conTrong = 1
        case dangGoiMon = 2
        case dangPhucVu = 3
        case datTruoc = 4
        func getImage() -> UIImage {
            switch self {
            case .conTrong:
                return UIImage(named: "ic_tablett1")!
            case .dangGoiMon:
                return UIImage(named: "ic_tablett2")!
            case .dangPhucVu:
                return UIImage(named: "ic_tablett3")!
            case .datTruoc:
                return UIImage(named: "ic_tablett4")!
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
        if trangThaiChon == false {
            imgCheck.isHidden = false
            passDataSelect?(item)
        }else {
            imgCheck.isHidden = true
            passDataDelete?(item)
        }
        trangThaiChon = !trangThaiChon
    }
    
}

