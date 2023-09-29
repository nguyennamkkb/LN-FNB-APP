//
//  BanDatTruocVC.swift
//  LN FNB
//
//  Created by namnl on 29/09/2023.
//

import UIKit

class BanDatTruocVC: BaseVC {

    @IBOutlet var bAdd: UIButton!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bAdd.layer.cornerRadius = C.CornerRadius.corner5
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "BanDatTruocCell")
        // Do any additional setup after loading the view.
    }


}
extension BanDatTruocVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BanDatTruocCell", for: indexPath) as? BanDatTruocCell else { return UITableViewCell()}
        return cell
    }
    
    
}
