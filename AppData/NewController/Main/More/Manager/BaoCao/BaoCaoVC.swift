//
//  BaoCaoVC.swift
//  LN FNB
//
//  Created by namnl on 12/11/2023.
//

import UIKit

class BaoCaoVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bHomNay: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "BaoCaoCell")
    }
    func setupUI(){
        bHomNay.layer.cornerRadius = C.CornerRadius.corner10
    }



}
extension BaoCaoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaoCaoCell", for: indexPath) as? BaoCaoCell else { return UITableViewCell()}

        return cell
    }
    
    
}
