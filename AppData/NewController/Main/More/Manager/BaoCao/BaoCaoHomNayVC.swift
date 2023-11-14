//
//  BaoCaoVC.swift
//  LN FNB
//
//  Created by namnl on 12/11/2023.
//

import UIKit

class BaoCaoHomNayVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bXemNgayKhac: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "BaoCaoHomNayCell")
        setupUI()
    }
    func setupUI(){
        bXemNgayKhac.layer.cornerRadius = C.CornerRadius.corner10
    }
    @IBAction func xemNgayKhacPressed(_ sender: Any) {
        let vc = BaoCaoTheoNgayVC()
        self.pushVC(controller: vc)
    }
    


}
extension BaoCaoHomNayVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BaoCaoHomNayCell", for: indexPath) as? BaoCaoHomNayCell else { return UITableViewCell()}

        return cell
    }
    
    
}
