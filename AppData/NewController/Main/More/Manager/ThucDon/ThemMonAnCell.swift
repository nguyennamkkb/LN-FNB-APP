//
//  ThemMonAnCell.swift
//  LN FNB
//
//  Created by namnl on 28/09/2023.
//

import UIKit
import DropDown

class ThemMonAnCell: UITableViewCell {

    
    var passData: ClosureCustom<FProduct>?
    var item = FProduct()
    var categorySelected = FCategory()
    @IBOutlet var tfDescription: UITextField!
    var listCategory = [FCategory]()
    @IBOutlet var lbCategory: UILabel!
    @IBOutlet var tfCost: UITextField!
    @IBOutlet var tfPrice: UITextField!
    @IBOutlet var tfName: UITextField!
    @IBOutlet var bXacNhan: UIButton!
    @IBOutlet var V5: UIView!
    @IBOutlet var V4: UIView!
    @IBOutlet var imgMonAn: UIImageView!
    @IBOutlet var bChonAnh: UIButton!
    @IBOutlet var V3: UIView!
    @IBOutlet var V2: UIView!
    @IBOutlet var V1: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
        
       
    }
    func setupUI(){
        V1.layer.cornerRadius = C.CornerRadius.corner10
        V2.layer.cornerRadius = C.CornerRadius.corner10
        V3.layer.cornerRadius = C.CornerRadius.corner10
        V4.layer.cornerRadius = C.CornerRadius.corner10
        V5.layer.cornerRadius = C.CornerRadius.corner10
        bChonAnh.layer.cornerRadius = C.CornerRadius.corner10
        imgMonAn.layer.cornerRadius = C.CornerRadius.corner10
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner10
    }
    func bindDataCategories(list: [FCategory]){
        self.listCategory = list

    }
    func bindData(item: FProduct){
        self.item = item
        tfName.text = item.name
        tfPrice.text = "\(item.price ?? 0)"
        tfCost.text = "\(item.cost ?? 0)"
        tfDescription.text = item.description
        categorySelected = listCategory.first(where: { $0.id == item.category_id }) ?? FCategory()
        lbCategory.text = categorySelected.name ?? "Chọn danh mục"
    }
    @IBAction func chonDanhMucPressed(_ sender: UIButton) {
        var list =  [String]()
        if listCategory.count == 0 {
            return
        }
        let dropDown = DropDown()
        listCategory.forEach{
            list.append($0.name ?? "")
        }
        dropDown.dataSource = list
        dropDown.anchorView = sender //5
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
        dropDown.show() //7
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let self = self else { return }
            self.lbCategory.text = item
            self.categorySelected = self.listCategory.itemAtIndex(index: index) ?? FCategory()
        }
    }

    
    @IBAction func xacNhanPressed(_ sender: Any) {
//        print(listCategory.toJSON())
        guard let name = tfName.text else {return}
        guard let price = tfPrice.text else {return}
        guard let cost = tfCost.text else {return}
        let description = tfDescription.text ?? ""
        item.name = name
        item.price = Int(price)
        item.cost = Int(cost)
        item.description = description
        item.category_id = categorySelected.id
        item.user_id = categorySelected.user_id
        passData?(item)
    }
}
