//
//  MessageVC.swift
//  LN FNB
//
//  Created by namnl on 29/09/2023.
//

import UIKit

class MessageVC: BaseVC {

    @IBOutlet var bXacNhan: UIButton!
    @IBOutlet var bClose: UIButton!
    @IBOutlet var lbMessage: UILabel!
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var VScreen: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    @IBAction func closePressed(_ sender: Any) {
        self.onBackNav()
    }
    func bindData(title: String?, content: String?){
        lbTitle.text = "\(title ?? "Thông báo")"
        lbMessage.text = "\(content ?? "Đồng ý với lựa chọn?")"
    }
    func setupUI() {
        bClose.layer.cornerRadius = C.CornerRadius.corner5
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner5
        lbTitle.text = "Thông báo"
        lbMessage.text = "Đồng ý với lựa chọn?"
        VScreen.backgroundColor = C.Color.Black
        
    }
    @IBAction func xacNhanPressed(_ sender: Any) {
        self.onBackNav()
    }

}
