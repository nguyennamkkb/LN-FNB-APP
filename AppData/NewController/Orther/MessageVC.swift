//
//  MessageVC.swift
//  LN FNB
//
//  Created by namnl on 29/09/2023.
//

import UIKit

class MessageVC: BaseVC {

    var title1: String = "Thông báo"
    var content1: String = "Đồng ý với lựa chọn?"
    var actionOK: ClosureAction?
    @IBOutlet var bXacNhan: UIButton!
    @IBOutlet var bClose: UIButton!
    @IBOutlet var lbMessage: UILabel!
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var VScreen: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        lbTitle.text = title1
        lbMessage.text = content1
    }

    @IBAction func closePressed(_ sender: Any) {
        self.onBackNav()
    }
    func bindData(title: String?, content: String?){
        title1 = "\(title ?? "Thông báo")"
        content1 = "\(content ?? "Đồng ý với lựa chọn?")"
    }
    func setupUI() {
        bClose.layer.cornerRadius = C.CornerRadius.corner10
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner10
        lbTitle.text = "Thông báo"
        lbMessage.text = "Đồng ý với lựa chọn?"
        VScreen.backgroundColor = C.Color.Black
        
    }
    @IBAction func xacNhanPressed(_ sender: Any) {
        actionOK?()
        self.onBackNav()
    }

}
