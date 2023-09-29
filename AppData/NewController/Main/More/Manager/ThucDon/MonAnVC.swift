//
//  MonAnVC.swift
//  LN FNB
//
//  Created by namnl on 28/09/2023.
//

import UIKit
import FittedSheets

class MonAnVC: BaseVC {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var vSearch: UIView!
    @IBOutlet var bAdd: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "QLMonAnCell")

        
    }
    @IBAction func AddPressed(_ sender: Any) {
        let vc = ThemMonAnVC()
        self.pushVC(controller: vc)
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    func setupUI(){
        vSearch.layer.cornerRadius = C.CornerRadius.corner5
        bAdd.layer.cornerRadius = C.CornerRadius.corner5
    }
}
extension MonAnVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QLMonAnCell", for: indexPath) as? QLMonAnCell else {return UITableViewCell()}
        
        cell.actionEdit = {
            [weak self] in
            guard let self = self else {return}
            self.pushVC(controller: ThemMonAnVC())
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

