//
//  SignUpInfoVC.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class SignUpInfoVC: BaseVC {
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "SingUpInfoCell")
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    
}

extension SignUpInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SingUpInfoCell", for: indexPath) as? SingUpInfoCell else  {return UITableViewCell()}
        cell.actionXacNhan = {
            [weak self] in
            guard let self = self else {return}
            self.pushVC(controller: LoginVC())
        }
        return cell
    }
    
    
}
