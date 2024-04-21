//
//  MonAnThemAnhVC.swift
//  LN FNB
//
//  Created by namnl on 17/11/2023.
//

import UIKit
import Kingfisher
class MonAnThemAnhVC: BaseVC {

    @IBOutlet var lbMess: UILabel!
    var uploadMacDinh: ClosureAction?
    var uploadThanhCong: ClosureCustom<String>?
    var base64String: String = ""
    @IBOutlet var bChonAnhKhac: UIButton!
    @IBOutlet var bXacNhan: UIButton!
    @IBOutlet var anhSanPham: UIImageView!
    var item = FProduct()
    var urlImage: String = "anhSanPhamMacDinh"
    override func viewDidLoad() {
        super.viewDidLoad()

        bXacNhan.layer.cornerRadius = C.CornerRadius.corner10
        bChonAnhKhac.layer.cornerRadius = C.CornerRadius.corner10
        anhSanPham.layer.cornerRadius = C.CornerRadius.corner10
        bChonAnhKhac.layer.borderWidth = 1
        bChonAnhKhac.layer.borderColor = C.Color.NYellow?.cgColor
        
        if let url = URL(string: ServiceManager.ROOT+"images/viewimage/"+(item.image ?? "anhSanPhamMacDinh")) {
            anhSanPham.loadImageFromUrl(from: url)
        }else {
            anhSanPham.kf.setImage(with:URL(string: ServiceManager.ROOT+"images/viewimage/anhSanPhamMacDinh"))
        }
    }
    func bindData(e: FProduct){
        item = e
        urlImage = e.image ?? "anhSanPhamMacDinh"
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    
    @IBAction func chonAnhTuMay(_ sender: Any) {
        self.showLoading()
        // Tạo một đối tượng UIImagePickerController
        let imagePicker = UIImagePickerController()
        
        // Thiết lập nguồn ảnh là thư viện ảnh
        imagePicker.sourceType = .photoLibrary
        
        // Cho phép người dùng chỉnh sửa ảnh
        imagePicker.allowsEditing = true
        
        // Thiết lập delegate là chính ViewController này
        imagePicker.delegate = self
        
        // Hiển thị đối tượng UIImagePickerController
        self.hideLoading()
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let image = info[.editedImage] as? UIImage {
            base64String = "data:image/jpeg;base64," + (image.resizeWidth(100)?.jpegData(compressionQuality: 0.1)?.base64EncodedString() ?? "")
            anhSanPham.image = image
        }
        picker.dismiss(animated:    true, completion: nil)
    }
    @IBAction func xacNhanPressed(_ sender: Any) {
        if base64String.count < 100 {
            self.onBackNav(animated: false)
            uploadMacDinh?()
            return;
        }
        let anhSanPham = FPramUploadImage()
        anhSanPham.user_id = Common.userMaster.id
        anhSanPham.idSanPham = item.id
        anhSanPham.createAt = Int(item.createAt ?? "0")
        anhSanPham.base64Image = base64String

        ServiceManager.common.taiAnhSanPhamLen(param: anhSanPham){
            (response) in
            if response?.data != nil, response?.statusCode == 200 {
                self.showAlert(message: "Thành công!")
                self.uploadThanhCong?(response?.data as! String)
                self.onBackNav(animated: false)
            } else if response?.statusCode == 0 {
                self.lbMess.isHidden = false
                self.lbMess.text = "Không thể tải ảnh lên lúc này, ảnh mặc định sẽ hiển thị thay thể, chọn dấu x để bỏ qua bước này"
            }
        }
        
    }


}
