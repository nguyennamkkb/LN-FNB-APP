//
//  LocHoaDonVC.swift
//  LN FNB
//
//  Created by namnl on 30/09/2023.
//

import UIKit

class LocHoaDonVC: BaseVC {
    
    @IBOutlet weak var bXacNhan: UIButton!
    let datePickerTuNgay = UIDatePicker()
    let datePickerDenNgay = UIDatePicker()
    @IBOutlet weak var ftDenNgay: UITextField!
    @IBOutlet weak var tfTuNgay: UITextField!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        v1.layer.cornerRadius = C.CornerRadius.corner10
        v2.layer.cornerRadius = C.CornerRadius.corner10
        bXacNhan.layer.cornerRadius = C.CornerRadius.corner10
        
        setupData()
        setupDatePicker()
    }
    func setupDatePicker(){
        //tu ngay
        datePickerTuNgay.datePickerMode = .date
        datePickerTuNgay.addTarget(self, action: #selector(dateChangeTu(datePicker:)), for: UIControl.Event.valueChanged)
        datePickerTuNgay.frame.size = CGSize(width: 0, height: 300)
        if #available(iOS 13.4, *) {
            datePickerTuNgay.preferredDatePickerStyle = .wheels
        }
        tfTuNgay.inputView = datePickerTuNgay
        
        //den ngay
        datePickerDenNgay.datePickerMode = .date
        datePickerDenNgay.addTarget(self, action: #selector(dateChangeDen(datePicker:)), for: UIControl.Event.valueChanged)
        datePickerDenNgay.frame.size = CGSize(width: 0, height: 300)
        if #available(iOS 13.4, *) {
            datePickerDenNgay.preferredDatePickerStyle = .wheels
        }
        ftDenNgay.inputView = datePickerDenNgay
        
    }
    @IBAction func xacNhanPressed(_ sender: Any) {
        self.onBackNav()
    }
    func setupData(){
        tfTuNgay.text = formatDate(date: Date())
        ftDenNgay.text = formatDate(date: Date())
        
    }
   
    @objc func dateChangeTu(datePicker: UIDatePicker) {
        tfTuNgay.text = formatDate(date: datePicker.date)
    }
    @objc func dateChangeDen(datePicker: UIDatePicker) {
        ftDenNgay.text = formatDate(date: datePicker.date)
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
