//
//  SingUpInfoCell.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class SingUpInfoCell: UITableViewCell {
    
    
    @IBOutlet weak var tfSDT: UITextField!
    @IBOutlet weak var tfDiaChi: UITextField!
    @IBOutlet weak var tfTenCuaHang: UITextField!
    @IBOutlet weak var tfHoTen: UITextField!
    
    var actionXacNhan: ClosureCustom<PStore>?
    @IBOutlet var btnXacNhan: UIButton!
    @IBOutlet var btnChonLogo: UIButton!
    @IBOutlet var btnChonQR: UIButton!
    @IBOutlet var view4: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view1: UIView!
    var store = PStore()
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }
    func bindData(item: PStore){
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func getData(){
        guard let hoTen =  tfHoTen.text else {return}
        guard let tenCuaHang =  tfTenCuaHang.text else {return}
        guard let diaChi =  tfDiaChi.text else {return}
        guard let soDienThoai =  tfSDT.text else {return}
        store.name_own = hoTen
        store.address=diaChi
        store.phone = soDienThoai
        store.storeName = tenCuaHang
        
        actionXacNhan?(store)
    }
    func setupUI(){
        view1.layer.cornerRadius = C.CornerRadius.corner10
        view2.layer.cornerRadius = C.CornerRadius.corner10
        view3.layer.cornerRadius = C.CornerRadius.corner10
        view4.layer.cornerRadius = C.CornerRadius.corner10
        btnChonLogo.layer.cornerRadius = C.CornerRadius.corner10
        btnChonQR.layer.cornerRadius = C.CornerRadius.corner10
        btnXacNhan.layer.cornerRadius = C.CornerRadius.corner10
    }
    @IBAction func xacNhanPressed(_ sender: Any) {
        getData()
    }
    
}
