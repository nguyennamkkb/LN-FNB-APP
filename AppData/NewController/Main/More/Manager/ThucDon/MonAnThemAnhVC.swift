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
    @IBOutlet var bClose: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        bClose.layer.cornerRadius = C.CornerRadius.corner10
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner10
        bChonAnhKhac.layer.cornerRadius = C.CornerRadius.corner10
        anhSanPham.layer.cornerRadius = C.CornerRadius.corner10
        bChonAnhKhac.layer.borderWidth = 1
        bChonAnhKhac.layer.borderColor = C.Color.NYellow?.cgColor
        
        let url = URL(string: "http://14.225.254.151:3457/ln-fnb-api/images/viewimage/"+urlImage)
        anhSanPham.kf.setImage(with: url)
    }
    func bindData(e: FProduct){
        item = e
        urlImage = e.image ?? "anhSanPhamMacDinh"
    }

    @IBAction func chonAnhTuMay(_ sender: Any) {
        // Tạo một đối tượng UIImagePickerController
        let imagePicker = UIImagePickerController()
        
        // Thiết lập nguồn ảnh là thư viện ảnh
        imagePicker.sourceType = .photoLibrary
        
        // Cho phép người dùng chỉnh sửa ảnh
        imagePicker.allowsEditing = true
        
        // Thiết lập delegate là chính ViewController này
        imagePicker.delegate = self
        
        // Hiển thị đối tượng UIImagePickerController
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
            uploadMacDinh?()
            self.onBackNav()
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
                self.onBackNav()
            } else if response?.statusCode == 0 {
                self.lbMess.isHidden = false
                self.lbMess.text = "Không thể tải ảnh lên lúc này, ảnh mặc định sẽ hiển thị thay thể, chọn dấu x để bỏ qua bước này"
            }
        }
        
    }


}
