//
//  MonAnCell.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class MonAnCell: UITableViewCell {

    @IBOutlet var imgItem: UIImageView!
    @IBOutlet var VLine: UIView!
    @IBOutlet var vItem: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
//        vItem.layer.cornerRadius = C.CornerRadius.corner10
        imgItem.layer.cornerRadius = C.CornerRadius.corner5
        VLine.layer.shadowOpacity = 0.5
        VLine.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
}
