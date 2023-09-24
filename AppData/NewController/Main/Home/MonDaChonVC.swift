//
//  MonDaChonVC.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class MonDaChonVC: BaseVC {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnXacNhan: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "MonDaChonCell")
        setupUI()
        
    }
    func setupUI(){
        btnXacNhan.layer.cornerRadius = C.CornerRadius.corner5
    }
    @IBAction func xacNhanPressed(_ sender: Any) {
        self.pushVC(controller: BanDangPhucVuVC())
    }
    
}


extension MonDaChonVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MonDaChonCell", for: indexPath) as? MonDaChonCell else {return UITableViewCell()} 
        return cell
    }
    
    
}
