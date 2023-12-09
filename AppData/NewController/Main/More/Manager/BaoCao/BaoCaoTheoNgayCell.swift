//
//  BaoCaoCell.swift
//  LN FNB
//
//  Created by namnl on 12/11/2023.
//

import UIKit
import DGCharts


class BaoCaoTheoNgayCell: UITableViewCell, ChartViewDelegate {
    
    
    
    
    @IBOutlet weak var chartView: UIView!
    var barChartView: BarChartView!
    
    var layThoiGian: ((Int64,Int64,String,String) -> Void)?
    let datePickerTuNgay = UIDatePicker()
    let datePickerDenNgay = UIDatePicker()
    var data = FThongKeTheoNgay()
    @IBOutlet weak var bLoc: UIButton!
    @IBOutlet weak var lbTNSoKhach: UILabel!
    @IBOutlet weak var lbTNHoaDon: UILabel!
    @IBOutlet weak var lbTNChuyenKhoan: UILabel!
    @IBOutlet weak var lbTNTienMat: UILabel!
    @IBOutlet weak var lbTNDoanhThu: UILabel!
    @IBOutlet weak var lbTNNgay: UILabel!
    @IBOutlet weak var lbTQTaiBan: UILabel!
    @IBOutlet weak var lbTQMangDi: UILabel!
    
    @IBOutlet weak var lbTQSoKhach: UILabel!
    @IBOutlet weak var lbTQHoaDon: UILabel!
    @IBOutlet weak var lbTQChuyenKhoan: UILabel!
    @IBOutlet weak var lbTQTienMat: UILabel!
    @IBOutlet weak var lbTQDoanhThu: UILabel!
    @IBOutlet weak var vTheoNgay: UIView!
    @IBOutlet weak var vLoaiAn: UIView!
    @IBOutlet weak var vTongQuan: UIView!
    @IBOutlet weak var tfDenNgay: UITextField!
    @IBOutlet weak var tfTuNgay: UITextField!
    @IBOutlet weak var vDenNgay: UIView!
    @IBOutlet weak var vTuNgay: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupDatePicker()
    }
    func setupUI(){
        vDenNgay.layer.cornerRadius = C.CornerRadius.corner10
        bLoc.layer.cornerRadius = C.CornerRadius.corner10
        vTuNgay.layer.cornerRadius = C.CornerRadius.corner10
        vLoaiAn.layer.cornerRadius = C.CornerRadius.corner10
        vTheoNgay.layer.cornerRadius = C.CornerRadius.corner10
        vTongQuan.layer.cornerRadius = C.CornerRadius.corner10
        
        barChartView = BarChartView(frame: CGRect(x: 0, y: 0, width: chartView.frame.width - 40, height: chartView.frame.height))
        chartView.addSubview(barChartView)
        barChartView.delegate = self
    }
    func bindData(e: FThongKeTheoNgay, tu: String, den: String){
        if tu == "", den == "" {
            tfTuNgay.text = formatDate(date: Date())
            tfDenNgay.text = formatDate(date: Date())
        }else {
            tfTuNgay.text = tu
            tfDenNgay.text = den
        }
        
        data = e
        if data.rpTheoNgay?.count == 0 {return}
        lbTQDoanhThu.text = "Doanh thu: " + "\((data.tongTienCK ?? 0) + (data.tongTienMat ?? 0))".currencyFormatting() + "đ"
        lbTQTienMat.text = "Tiền mặt: " + "\(data.tongTienMat ?? 0)".currencyFormatting() + "đ"
        lbTQChuyenKhoan.text = "Tiền mặt: " + "\(data.tongTienCK ?? 0)".currencyFormatting() + "đ"
        lbTQHoaDon.text = "Hoá đơn: " + "\(data.tongSoDonHang ?? 0)".currencyFormatting()
        lbTQSoKhach.text = "Số khách: " + "\(data.tongSoKhach ?? 0)".currencyFormatting()
        lbTQMangDi.text = "\(data.tongDonShip ?? 0)".currencyFormatting()
        lbTQTaiBan.text = "\(((data.tongSoDonHang ?? 0) - (data.tongDonShip ?? 0)))".currencyFormatting()
        
        setupHorizontalBarChart()
    }
    func setupData(){
        
    }
    @IBAction func locXacNhanThoiGianPressed(_ sender: Any) {
        guard let tuNgay = tfTuNgay.text else {return}
        guard let denNgay = tfDenNgay.text else {return}
        let tuNgayMilis:Int64 = Common.dateStringToMilis(dateString: tuNgay) ?? 0
        let denNgayMilis:Int64 = Common.dateStringToMilis(dateString: denNgay) ?? 0 + 86399999
        layThoiGian?(tuNgayMilis,denNgayMilis,tuNgay, denNgay)
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
        tfDenNgay.inputView = datePickerDenNgay
        
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
    
    
    func setupHorizontalBarChart() {
        var dataEntries = [BarChartDataEntry]()
        guard let rpTheoNgay = data.rpTheoNgay else { return }
        var i = 0
        for rpTheoNgay in rpTheoNgay {
            let total = rpTheoNgay.value!.reduce(0) { $0 + $1.total! }
            dataEntries.append(BarChartDataEntry(x: Double(i), y: Double(total)))
            i += 1
        }
        
        let dataSet = BarChartDataSet(entries: dataEntries, label: "Chạm vào cột để xem thông tin")
        
        // Add data labels to the chart
        dataSet.valueFormatter = DefaultValueFormatter(decimals: 0)
        dataSet.valueTextColor = .black
        
        dataSet.drawValuesEnabled = false // Enable displaying data values on the bars
        
        let data = BarChartData(dataSet: dataSet)
        barChartView.data = data
        barChartView.tintColor = UIColor.red
        barChartView.doubleTapToZoomEnabled = false
        // Hide all the labels and axes
        barChartView.xAxis.drawLabelsEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawLabelsEnabled = false
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.rightAxis.drawLabelsEnabled =     false
        barChartView.rightAxis.drawAxisLineEnabled = false
        
        // Hide grid lines
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawGridLinesEnabled = false
        setupDataGioDauTIen()
    }
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        // Hide or do something when no column is selected
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
                // Show the data value for the selected column

        let rpTheoNgay = data.rpTheoNgay!.itemAtIndex(index: Int(entry.x))
        var tongTienMat: Int = 0
        var tongCK: Int = 0
        var tongKhach: Int = 0
        for e in rpTheoNgay!.value! {
            if e.type == 1 {
                tongTienMat += e.total ?? 0
            } else if e.type == 2 {
                tongCK += e.total ?? 0
            }
            tongKhach += e.person ?? 0
        }
        lbTNNgay.text = "Ngày: \(rpTheoNgay?.date ?? "")"
        lbTNDoanhThu.text = "Doanh thu: " + "\(tongCK + tongTienMat)".currencyFormatting() + "đ"
        lbTNTienMat.text = "Tiền mặt: " + "\(tongTienMat)".currencyFormatting() + "đ"
        lbTNChuyenKhoan.text = "Chuyển khoản: " + "\(tongCK)".currencyFormatting() + "đ"
        lbTNHoaDon.text = "Hoá đơn" + "\(rpTheoNgay?.value?.count ?? 0)"
        lbTNSoKhach.text = "Số khách" + "\(tongKhach)".currencyFormatting()
    }
    func setupDataGioDauTIen(){

        guard let rpTheoNgay = data.rpTheoNgay else { return }

        var tongTienMat: Int = 0
        var tongCK: Int = 0
        var tongKhach: Int = 0
        let rpNgayDau = rpTheoNgay.itemAtIndex(index: 0)
        
        for e in rpNgayDau!.value! {
            if e.type == 1 {
                tongTienMat += e.total ?? 0
            } else if e.type == 2 {
                tongCK += e.total ?? 0
            }
            tongKhach += e.person ?? 0
        }
        lbTNNgay.text = "Ngày: \(rpNgayDau?.date ?? "")"
        lbTNDoanhThu.text = "Doanh thu: " + "\(tongCK + tongTienMat)".currencyFormatting() + "đ"
        lbTNTienMat.text = "Tiền mặt: " + "\(tongTienMat)".currencyFormatting() + "đ"
        lbTNChuyenKhoan.text = "Chuyển khoản: " + "\(tongCK)".currencyFormatting() + "đ"
        lbTNHoaDon.text = "Hoá đơn" + "\(rpNgayDau?.value?.count ?? 0)"
        lbTNSoKhach.text = "Số khách" + "\(tongKhach)".currencyFormatting()
    }
}
