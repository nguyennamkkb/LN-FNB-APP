//
//  SignUpInfoVC.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class SignUpInfoVC: BaseVC {
    
    @IBOutlet var vTop: UIView!
    var store = PStore()
    @IBOutlet var tableView: UITableView!
    var trangThaiSua: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        vTop.addCornerRadiusToBottom(radius: 10.0)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.registerCell(nibName: "SingUpInfoCell")
    }
    
    func bindData(item: PStore){
        store =  item
        trangThaiSua = 0
        
    }
    
    func bindDataSua(item: PStore){
        store =  item
        trangThaiSua = 1
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    func updateStore(){
        
        store.sign()
        ServiceManager.common.updateUser(param: self.store){
            (response) in
            self.hideLoading()
            if response?.statusCode == 200 {
                CacheManager.share.setRegister(true)
                Common.userMaster = self.store
                self.showAlert(message: "Thành công!")
            } else {
                self.showAlert(message: "Lỗi thêm mới")
            }
        }
    }
}

extension SignUpInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SingUpInfoCell", for: indexPath) as? SingUpInfoCell else  {return UITableViewCell()}
        cell.actionXacNhan = {
            [weak self] item in
            guard let self = self else {return}
            
            if trangThaiSua == 1 {
                self.store.name_own = item.name_own
                self.store.storeName = item.storeName
                self.store.phone = item.phone
                self.store.address = item.address
                
                self.updateStore();
            }else {
                self.store.name_own = item.name_own
                self.store.storeName = item.storeName
                self.store.address = item.address
                self.store.phone = item.phone
                ServiceManager.common.createUser(param: self.store){
                    (response) in
                    self.hideLoading()
                    if response?.statusCode == 200 {
                        CacheManager.share.setRegister(true)
                        let vc = LoginVC()
                        vc.bindData(item: self.store)
                        self.pushVC(controller: vc)
                    } else {
                        self.showAlert(message: "Lỗi thêm mới")
                    }
                }
            }
            
            
        }
        cell.bindData(item: store)
        return cell
    }
    
}
