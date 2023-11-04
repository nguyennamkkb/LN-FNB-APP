//
//  AlertVC.swift
//  LN FNB
//
//  Created by namnl on 12/10/2023.
//

import UIKit

class AlertVC: UIViewController {

    var actionFinish: ClosureAction?
    var message: String?
    @IBOutlet var lbMessage: UILabel?
    @IBOutlet var vAleart: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        vAleart.layer.cornerRadius = C.CornerRadius.corner10
        vAleart.layer.shadowColor = UIColor.black.cgColor
        vAleart.layer.shadowOpacity = 1
        vAleart.layer.shadowOffset = .zero
        vAleart.layer.shadowRadius = 10
        lbMessage?.text = message ?? ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.actionFinish?()
            self.dismiss(animated: false)
        }
    }
    func bindData(s: String){
        message = s
    }
    
}
