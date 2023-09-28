//
//  ThemMonAnVC.swift
//  LN FNB
//
//  Created by namnl on 29/09/2023.
//

import UIKit

class ThemMonAnVC: BaseVC {

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "ThemMonAnCell")
    }

}
extension ThemMonAnVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThemMonAnCell", for: indexPath) as? ThemMonAnCell else {return UITableViewCell()}
        return cell
    }
}
