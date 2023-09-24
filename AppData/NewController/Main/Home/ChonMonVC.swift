//
//  ChonMonVC.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class ChonMonVC: BaseVC{
 

    @IBOutlet var tableView: UITableView!
    @IBOutlet var viewSearch: UIView!
    
    enum Section: String {
        case monChinh = "Món chính"
        case monPhu = "Món phụ"
        case trangMieng = "Tráng miệng"
        case doUong = "Đồ uống"
    }
    
    let listSection: [Section] = [.monChinh,.monPhu,.trangMieng,.doUong]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.registerCell(nibName: "MonAnCell")
        setupUI()
    }
    func setupUI(){
        viewSearch.layer.cornerRadius = C.CornerRadius.corner10
    }
    @IBAction func cartPressed(_ sender: Any) {
        self.pushVC(controller: MonDaChonVC() )
    }
    
    
}


extension ChonMonVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0 // Adjust this value to set the desired spacing between sections
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return listSection.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MonAnCell", for: indexPath) as? MonAnCell else {return UITableViewCell()}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Create a custom view for section headers (optional)
        let headerView = UIView()
//        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.frame.size.width, height: 30.0))
        headerView.backgroundColor = C.Color.Navi

        // Add a label for the section title
        let label = UILabel()
        label.textColor = C.Color.White
        label.font =  UIFont(name: "Roboto-Medium", size: 16)
        label.text = listSection.itemAtIndex(index: section)?.rawValue
        label.frame = CGRect(x: 15, y: 0, width: tableView.frame.size.width, height: 30)
        headerView.addSubview(label)
        return headerView
    }
    
}
