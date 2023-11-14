//
//  BaoCaoNgayKhacVC.swift
//  LN FNB
//
//  Created by namnl on 14/11/2023.
//

import UIKit

class BaoCaoTheoNgayVC: BaseVC {

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "BaoCaoTheoNgayCell")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension BaoCaoTheoNgayVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaoCaoTheoNgayCell", for: indexPath) as? BaoCaoTheoNgayCell else { return UITableViewCell()}

        return cell
    }
    
    
}
