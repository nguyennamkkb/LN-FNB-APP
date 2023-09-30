//
//  CuaHangVC.swift
//  LN FNB
//
//  Created by namnl on 30/09/2023.
//

import UIKit

class CuaHangVC: BaseVC {
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "CuaHangCell")
      //CuaHangCell
    }


}
extension CuaHangVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CuaHangCell", for: indexPath) as? CuaHangCell else { return UITableViewCell()}
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
