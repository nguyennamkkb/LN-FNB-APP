//
//  SingUpInfoCell.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class SingUpInfoCell: UITableViewCell {
    
    var actionXacNhan: ClosureAction?
    @IBOutlet var btnXacNhan: UIButton!
    @IBOutlet var btnChonLogo: UIButton!
    @IBOutlet var btnChonQR: UIButton!
    @IBOutlet var view4: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view1: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setupUI(){
        view1.layer.cornerRadius = C.CornerRadius.corner10
        view2.layer.cornerRadius = C.CornerRadius.corner10
        view3.layer.cornerRadius = C.CornerRadius.corner10
        view4.layer.cornerRadius = C.CornerRadius.corner10
        btnChonLogo.layer.cornerRadius = C.CornerRadius.corner10
        btnChonQR.layer.cornerRadius = C.CornerRadius.corner10
        btnXacNhan.layer.cornerRadius = C.CornerRadius.corner5
    }
    @IBAction func xacNhanPressed(_ sender: Any) {
        actionXacNhan?()
    }
    
}
