  //
//  PhieuBepVC.swift
//  LN FNB
//
//  Created by namnl on 27/09/2023.
//

import UIKit

class PhieuBepVC: BaseVC {

    @IBOutlet var bXacNhan: UIButton!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "MonTrenBanCell")
        setupUI()
    }
    func setupUI(){
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner5
    }
    @IBAction func XacNhanPressed(_ sender: Any) {
        self.pushVC(controller: InPhieuBepVC())
    }
    
}
extension PhieuBepVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MonTrenBanCell", for: indexPath) as? MonTrenBanCell else {return UITableViewCell()}
        return cell
    }
    
}
