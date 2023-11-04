//
//  QLHoaDonVC.swift
//  LN FNB
//
//  Created by namnl on 30/09/2023.
//

import UIKit

class QLHoaDonVC: BaseVC {

    var actionFilter: ClosureAction?
    @IBOutlet var tableView: UITableView!
    @IBOutlet var vFilter: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "HoaDonCell")
        vFilter.layer.cornerRadius = C.CornerRadius.corner10
    }
    @IBAction func locPressed(_ sender: Any) {
        
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    


}
extension QLHoaDonVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HoaDonCell", for: indexPath) as? HoaDonCell else { return UITableViewCell()}
//        cell.actionEdit = {
//            [weak self] in
//            guard let self = self else {return}
//            let vc = ThemBanVC()
//            let sheet = SheetViewController(controller: vc, sizes: [.fixed(300)])
//            self.present(sheet, animated: true)
//        }
//        cell.actionDelete = {
//            [weak self] in
//            guard let self = self else {return}
//            let vc = MessageVC()
//            let sheet = SheetViewController(controller: vc, sizes: [.fixed(250)])
//            self.present(sheet, animated: true)
//        }
        return cell
    }
    
    
}
