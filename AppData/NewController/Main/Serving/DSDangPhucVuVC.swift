//
//  DSDangPhucVuVC.swift
//  LN FNB
//
//  Created by namnl on 28/09/2023.
//

import UIKit

class DSDangPhucVuVC: BaseVC {

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
         self.tableView.registerCell(nibName: "BanDangPhucVuCell")
    }
    



}
extension DSDangPhucVuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BanDangPhucVuCell", for: indexPath) as? BanDangPhucVuCell else {return UITableViewCell()}
        cell.actionChon = {
            [weak self] in
            guard let self = self else {return}
            let vc = BanDangPhucVuVC()
            self.pushVC(controller: vc)
        }
        return cell
    }
}
