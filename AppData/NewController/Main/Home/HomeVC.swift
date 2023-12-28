//
//  HomeVC.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit
import ObjectMapper

class HomeVC: BaseVC {
    
    @IBOutlet weak var bCapNhat: UIButton!
    @IBOutlet var vTop: UIView!
    @IBOutlet var bDatBan: UIButton!
    @IBOutlet var tenBanDaChon: UILabel!
    var listTableSelected: [FTable] = []
    @IBOutlet var btnChonMon: UIButton!
    let refreshControl = UIRefreshControl()
    var collectionData =  [FTable]()

    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "TableCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "TableCell")        // Do any additional setup after loading the view.
        setLayout()
        getTables()
        setupUI()
    }

    func setupUI(){
        vTop.addCornerRadiusToBottom(radius: 10.0)
        
        bCapNhat.layer.cornerRadius = C.CornerRadius.corner10
        btnChonMon.layer.cornerRadius = C.CornerRadius.corner10
        bDatBan.layer.cornerRadius = C.CornerRadius.corner10
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    @IBAction func capNhatPressed(_ sender: Any) {
        getTables()
        tenBanDaChon.text = ""
    }
    @IBAction func banDatTruocPressed(_ sender: Any) {
        let vc = BanDatTruocVC()
        self.pushVC(controller: vc)
    }
    @IBAction func chonMonPressed(_ sender: UIButton) {
//        print(listTableSelected.toJSON())
        let vc = ChonMonVC()
        let dsBan: String = dsBanChon()
        if dsBan.count <= 0 {
            let vc = AlertVC()
            vc.bindData(s: "Chọn bàn trước")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false)
            return
        }
        vc.bindData(ban: dsBan)
        self.pushVC(controller: vc)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        getTables()
        listTableSelected.removeAll()
        tenBanDaChon.text = "Còn trống: \(getTableEmpty())"
        collectionView.refreshControl?.endRefreshing()
    }
    func getTables(){
        self.showLoading()
        guard let id = Common.userMaster.id else {return}
        
        let param = ParamSearch(user_id: id, keySearch: "")
        
        ServiceManager.common.getAllTables(param: "?\(Utility.getParamFromDirectory(item: param.toJSON()))"){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.collectionData = Mapper<FTable>().mapArray(JSONObject: response!.data ) ?? [FTable]()
                
                DispatchQueue.main.async {
                    self.tenBanDaChon.text = "Còn trống: \(self.getTableEmpty())"
                    self.collectionView.reloadData()
                }
            } else if response?.statusCode == 0 {
                self.showAlert(message: "Không có dữ liệu")
            }
            self.hideLoading()
        }
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TableCell", for: indexPath) as? TableCell else {return UICollectionViewCell()}
        let item = collectionData.itemAtIndex(index: indexPath.row) ?? FTable()
        cell.bindData(item: item)
        cell.passDataSelect = {
            [weak self] data in
            guard let self = self else {return}
            addSelect(item: data)
        }
        cell.passDataDelete = {
            [weak self] data in
            guard let self = self else {return}
            deleteSelect(item: data)
        }
        cell.actionBanDangPhucVu = {
            let vc = AlertVC()
            vc.bindData(s: "Bàn đã có người")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false)
        }
        cell.actionBanDaDatTruoc = {
            let vc = AlertVC()
            vc.bindData(s: "Bàn đã đặt trước")
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false)
        }
        return cell
    }
    
    func setLayout(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let countItem = C.Screen.WIDTH / 100
        let totalSpaceScreen = C.Screen.WIDTH - countItem  * 100
        let width = 100.0
        let height = 66
        layout.minimumInteritemSpacing = totalSpaceScreen / countItem
        layout.minimumLineSpacing = 30
        layout.itemSize.width = width
        layout.itemSize.height = CGFloat(height)
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    func addSelect(item: FTable){
        listTableSelected.append(item)
        if listTableSelected.count > 0 {
        }
        updateTenBanChon()
    }
    func deleteSelect(item: FTable){
        listTableSelected = listTableSelected.filter { e in
            if let id = e.id {
                return id != item.id
            }
            return true
        }

        if listTableSelected.count <= 0 {
            tenBanDaChon.text = "Còn trống: \(getTableEmpty())"
            return
        }
        updateTenBanChon()
    }
    func updateTenBanChon(){
        tenBanDaChon.text = "Đang chọn: \(dsBanChon())"
    }
    func dsBanChon() -> String {
        var s: String = ""
        for e in listTableSelected {
            s += "\(e.name ?? "") "
        }
        return s
    }
    

    func getTableEmpty() -> Int {
        let empty = collectionData.filter { e in
            if let status = e.status {
                return status == 1
            }
            return false
        }
        return empty.count
    }
}
 
