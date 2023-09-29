//
//  QLBanVC.swift
//  LN FNB
//
//  Created by namnl on 29/09/2023.
//

import UIKit
import FittedSheets

class QLBanVC: BaseVC {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var bAdd: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "BanCell")
        setupUI()
        
    }
    @IBAction func addPressed(_ sender: Any) {
        let vc = ThemBanVC()
        let sheet = SheetViewController(controller: vc, sizes: [.fixed(300)])
        self.present(sheet, animated: true)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    
    func setupUI() {
        bAdd.layer.cornerRadius = C.CornerRadius.corner5
    }

}
extension QLBanVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BanCell", for: indexPath) as? BanCell else { return UITableViewCell()}
        cell.actionEdit = {
            [weak self] in
            guard let self = self else {return}
            let vc = ThemBanVC()
            let sheet = SheetViewController(controller: vc, sizes: [.fixed(300)])
            self.present(sheet, animated: true)
        }
        cell.actionDelete = {
            [weak self] in
            guard let self = self else {return}
            let vc = MessageVC()
            let sheet = SheetViewController(controller: vc, sizes: [.fixed(250)])
            self.present(sheet, animated: true)
        }
        return cell
    }
    
    
}
