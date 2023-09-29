//
//  DanhMucMonVC.swift
//  LN FNB
//
//  Created by namnl on 28/09/2023.
//

import UIKit
import FittedSheets

class DanhMucMonVC: BaseVC {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var bAdd: UIButton!
    @IBOutlet var VSearch: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "DanhMucCell")
        setupUI()
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    @IBAction func addPressed(_ sender: Any) {
        let vc = ThemDanhMucVC()
        let sheet = SheetViewController(controller: vc, sizes: [.fixed(300)])
        self.present(sheet, animated: true)
    }
    func setupUI(){
        VSearch.layer.cornerRadius = C.CornerRadius.corner5
        bAdd.layer.cornerRadius = C.CornerRadius.corner5
    }
    
}
extension DanhMucMonVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DanhMucCell", for: indexPath) as? DanhMucCell else {return UITableViewCell()}
        return cell
    }
}

