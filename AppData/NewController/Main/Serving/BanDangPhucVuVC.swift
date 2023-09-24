//
//  BanDangPhucVuVC.swift
//  LN FNB
//
//  Created by namnl on 24/09/2023.
//

import UIKit

class BanDangPhucVuVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnPhieuBep: UIButton!
    @IBOutlet weak var btnThanhToan: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerCell(nibName: "MonDaChonCell")
        setupUI()
    }
    func  setupUI() {
        btnThanhToan.layer.cornerRadius = C.CornerRadius.corner5
        btnPhieuBep.layer.cornerRadius = C.CornerRadius.corner5
    }
    
    
}
extension BanDangPhucVuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MonDaChonCell", for: indexPath) as? MonDaChonCell else {return UITableViewCell()}
        return cell
    }
}
