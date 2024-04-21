//
//  LocHoaDonVC.swift
//  LN FNB
//
//  Created by namnl on 30/09/2023.
//

import UIKit

class LocHoaDonVC: BaseVC {
    
    var layThoiGian: ((Int64,Int64,Int)->Void)?
    @IBOutlet weak var bXacNhan: UIButton!
    let datePickerTuNgay = UIDatePicker()
    let datePickerDenNgay = UIDatePicker()
    @IBOutlet weak var tfDenNgay: UITextField!
    @IBOutlet weak var tfTuNgay: UITextField!
    @IBOutlet weak var tfMaHoaDon: UITextField!
    
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v1: UIView!
    var tuNgay: String = ""
    var denNgay: String = ""
    
    var dateTuNgay: Date = Date()
    var dateDenNgay: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        v1.layer.cornerRadius = C.CornerRadius.corner10
        v2.layer.cornerRadius = C.CornerRadius.corner10
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner10
        tfMaHoaDon.layer.cornerRadius = C.CornerRadius.corner10

        
        setupData()
        setupDatePicker()
    }
    func bindData(tuNgay: Int64,denNgay: Int64) {
        dateTuNgay = Date(timeIntervalSince1970: Double(tuNgay) / 1000)
        dateDenNgay = Date(timeIntervalSince1970: Double(denNgay) / 1000)
    }
    func setupDatePicker(){
        //tu ngay
        datePickerTuNgay.datePickerMode = .date
        datePickerTuNgay.addTarget(self, action: #selector(dateChangeTu(datePicker:)), for: UIControl.Event.valueChanged)
        datePickerTuNgay.frame.size = CGSize(width: 0, height: 300)
        if #available(iOS 13.4, *) {
            datePickerTuNgay.preferredDatePickerStyle = .wheels
        }
        datePickerTuNgay.setDate(dateTuNgay, animated: true)
        tfTuNgay.inputView = datePickerTuNgay
        
        //den ngay
        datePickerDenNgay.datePickerMode = .date
        datePickerDenNgay.addTarget(self, action: #selector(dateChangeDen(datePicker:)), for: UIControl.Event.valueChanged)
        datePickerDenNgay.frame.size = CGSize(width: 0, height: 300)
        if #available(iOS 13.4, *) {
            datePickerDenNgay.preferredDatePickerStyle = .wheels
        }
        datePickerDenNgay.setDate(dateDenNgay, animated: true)
        tfDenNgay.inputView = datePickerDenNgay
        
    }
    @IBAction func xacNhanPressed(_ sender: Any) {

        guard let tuNgay = tfTuNgay.text else {return}
        guard let denNgay = tfDenNgay.text else {return}
        
        let maHoaDon = tfMaHoaDon.text ?? "0"
        let tuNgayMilis:Int64 = Common.dateStringToMilis(dateString: tuNgay) ?? 0
        let denNgayMilis:Int64 = (Common.dateStringToMilis(dateString: denNgay) ?? 0 ) + 86399999
        layThoiGian?(tuNgayMilis,denNgayMilis,Int(maHoaDon) ?? 0)
        self.onBackNav()
    }
    func setupData(){
        tfTuNgay.text = formatDate(date: dateTuNgay)
        tfDenNgay.text = formatDate(date: dateDenNgay)
    }
   
    @objc func dateChangeTu(datePicker: UIDatePicker) {
        tfTuNgay.text = formatDate(date: datePicker.date)
    }
    @objc func dateChangeDen(datePicker: UIDatePicker) {
        tfDenNgay.text = formatDate(date: datePicker.date)
    }
    func formatDate(date: Date) -> String {
        let formatrer =  DateFormatter()
        formatrer.dateFormat = "dd/MM/yyyy"
        return formatrer.string(from: date)
    }
    @IBAction func backPressed(_ sender: Any) {
        self.onBackNav()
    }
    
}
