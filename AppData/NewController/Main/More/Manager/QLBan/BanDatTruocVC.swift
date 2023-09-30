//
//  BanDatTruocVC.swift
//  LN FNB
//
//  Created by namnl on 29/09/2023.
//

import UIKit
import FittedSheets

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
    @IBAction func addPressed(_ sender: Any) {
        let vc = ThemBanDatTruocVC()
        let sheet = SheetViewController(controller: vc, sizes: [.fixed(410)])
        self.present(sheet, animated: true)
    }
    

}
extension BanDatTruocVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BanDatTruocCell", for: indexPath) as? BanDatTruocCell else { return UITableViewCell()}
        
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
