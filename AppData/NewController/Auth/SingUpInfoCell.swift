//
//  SingUpInfoCell.swift
//  LN FNB
//
//  Created by namnl on 17/09/2023.
//

import UIKit

class SingUpInfoCell: UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    weak var presentingViewController: UIViewController?
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var imgQR: UIImageView!
    
    @IBOutlet weak var tfSDT: UITextField!
    @IBOutlet weak var tfDiaChi: UITextField!
    @IBOutlet weak var tfTenCuaHang: UITextField!
    @IBOutlet weak var tfHoTen: UITextField!
    @IBOutlet weak var anhQR: UIImageView!
    @IBOutlet weak var anhLogo: UIImageView!
    
    var actionXacNhan: ClosureCustom<PStore>?
    var actionChonQR: ClosureAction?
    var actionChonLogo: ClosureAction?
    var passImg64QR: ClosureCustom<String>?
    var passImg64Logo: ClosureCustom<String>?
    
    var nutBam: Int = 0
    
    @IBOutlet var btnXacNhan: UIButton!
    @IBOutlet var view4: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view1: UIView!
    
    required init?(coder aDecoder: NSCoder?) {
         super.init(coder: aDecoder!)
            // ...
        }
    
    var base64String: String  = ""
    var store = PStore()
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }
    func bindData(item: PStore?){
        tfHoTen.text = item?.name_own ?? ""
        tfTenCuaHang.text = item?.storeName  ?? ""
        tfDiaChi.text = item?.address  ?? ""
        tfSDT.text = item?.phone  ?? ""
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func btnChonQrTuMay(_ sender: Any) {
        actionChonQR?()
        nutBam = 1
        chonAnh()

    }
    @IBAction func btnChonLogoPressed(_ sender: Any) {
        actionChonLogo?()
        
        nutBam = 2
        chonAnh()

    }
    func chonAnh(){
        // Tạo một đối tượng UIImagePickerController
        guard let presentingViewController = presentingViewController else { return }
            let imagePicker = UIImagePickerController()
        
        // Thiết lập nguồn ảnh là thư viện ảnh
        imagePicker.sourceType = .photoLibrary
        
        // Cho phép người dùng chỉnh sửa ảnh
        imagePicker.allowsEditing = true
        
        // Thiết lập delegate là chính ViewController này
        imagePicker.delegate = self
        
        // Hiển thị đối tượng UIImagePickerControllerÏ
//        present(imagePicker, animated: true)
        presentingViewController.present(imagePicker, animated: true, completion: nil)
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
        btnXacNhan.layer.cornerRadius = C.CornerRadius.corner10
        
        imgQR.layer.masksToBounds = true
        imgQR.layer.borderWidth = 1.5
        imgQR.layer.borderColor = UIColor.white.cgColor
        
        imgLogo.layer.masksToBounds = true
        imgLogo.layer.borderWidth = 1.5
        imgLogo.layer.borderColor = UIColor.white.cgColor
        
//        imgQR.kf.setImage(with:URL(string: ServiceManager.ROOT+"images/viewimage/qr"+String(Common.userMaster.id ?? 1)))
//
        let urlString : String = ServiceManager.ROOT+"images/viewimage/qr"+String(Common.userMaster.id ?? 0)
        print(urlString)
        if let url = URL(string: urlString ) {
            imgQR.loadImageFromUrl(from: url)
        }
        imgLogo.kf.setImage(with:URL(string: ServiceManager.ROOT+"images/viewimage/logo"+String(Common.userMaster.id ?? 0)))
    }
    @IBAction func xacNhanPressed(_ sender: Any) {
        getData()
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            self.base64String = "data:image/jpeg;base64," + (image.resizeWidth(100)?.jpegData(compressionQuality: 0.1)?.base64EncodedString() ?? "")
            if nutBam == 1 {
                passImg64QR?(self.base64String)
                anhQR.image = image
            }else if nutBam == 2 {
                passImg64Logo?(self.base64String)
                anhLogo.image = image
            }
            
        }
        picker.dismiss(animated:    true, completion: nil)
    }
}
