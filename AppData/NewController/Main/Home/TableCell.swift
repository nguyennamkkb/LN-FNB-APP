//
//  TableCell.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class TableCell: UICollectionViewCell {

    
    @IBOutlet weak var lbTableName: UILabel!
    @IBOutlet weak var imgTable: UIImageView!
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
        setTableImage()
    }

    func setTableImage(){
        imgTable.image = tableStatus.getImage(.conTrong)()
    }
    
}

