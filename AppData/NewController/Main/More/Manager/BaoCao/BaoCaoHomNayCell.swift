//
//  BaoCaoHomNayCell.swift
//  LN FNB
//
//  Created by namnl on 14/11/2023.
//

import UIKit
import DGCharts


class BaoCaoHomNayCell: UITableViewCell, ChartViewDelegate {
    
    
    
    @IBOutlet weak var chartView: UIView!
    var barChartView: BarChartView!
    var data = [RPTheoGio]()
    @IBOutlet var vTheoTungGio: UIView!
    @IBOutlet var vDaHoanThanh: UIView!
    @IBOutlet var vChuaHoanThanh: UIView!
    var actionReload: ClosureAction?
    @IBOutlet var bReload: UIButton!
    var item = FThongKeHomNay()
    @IBOutlet var lbTNTongSoKhach: UILabel!
    @IBOutlet var lbTNTongHoaDon: UILabel!
    @IBOutlet var lbTNTongCK: UILabel!
    @IBOutlet var lbTNTongTienMat: UILabel!
    @IBOutlet var lbTNTongDoanhThu: UILabel!
    @IBOutlet var lbTheoNgayNgay: UILabel!
    
    @IBOutlet var lbTongKhach: UILabel!
    @IBOutlet var lbTongHoaDon: UILabel!
    @IBOutlet var lbThuCK: UILabel!
    @IBOutlet var lbThuTienMat: UILabel!
    @IBOutlet var lbDoanhThu: UILabel!
    @IBOutlet var lbThuDuTinh: UILabel!
    @IBOutlet var lbSoKhach: UILabel!
    @IBOutlet var lbChuaDen: UILabel!
    @IBOutlet var lbShip: UILabel!
    @IBOutlet var lbAnTaiBan: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        bReload.layer.cornerRadius = C.CornerRadius.corner10
        vChuaHoanThanh.layer.cornerRadius = C.CornerRadius.corner10
        vDaHoanThanh.layer.cornerRadius = C.CornerRadius.corner10
        vTheoTungGio.layer.cornerRadius = C.CornerRadius.corner10
        //        barChartView = BarChartView(frame: CGRect(x: -10, y: 0, width: chartView.frame.width - 29 , height: chartView.frame.height))
        barChartView = BarChartView(frame: CGRect(x: 0, y: 0, width: chartView.frame.width , height: chartView.frame.height))
        chartView.addSubview(barChartView)
        barChartView.delegate = self
        
    }
    func bindData(e: FThongKeHomNay){
        item = e
        lbAnTaiBan.text = "\(item.chuaHoanThanh?.tongDangPhucVu ?? 0)".currencyFormatting()
        lbShip.text = "\(item.chuaHoanThanh?.tongShip ?? 0)".currencyFormatting()
        lbChuaDen.text = "\(item.chuaHoanThanh?.tongDatTruoc ?? 0)".currencyFormatting()
        lbSoKhach.text = "\(item.chuaHoanThanh?.tongKhach ?? 0)".currencyFormatting()
        lbThuDuTinh.text = "\(item.chuaHoanThanh?.tongThuDuTinh ?? 0)".currencyFormatting()
        
        lbDoanhThu.text = "Doanh thu:" + "\((item.daHoanThanh?.tongTienCK ?? 0)  + (item.daHoanThanh?.tongTienMat ?? 0 ))".currencyFormatting()
        lbThuTienMat.text = "• Tiền măt: " + "\(item.daHoanThanh?.tongTienMat ?? 0 )".currencyFormatting()
        lbThuCK.text = "• Chuyển khoản: " + "\(item.daHoanThanh?.tongTienCK ?? 0 )".currencyFormatting()
        lbTongHoaDon.text = "Hoá đơn: " + "\(item.daHoanThanh?.tongSoDonHang ?? 0 )".currencyFormatting()
        lbTongKhach.text = "Số khách: " + "\(item.daHoanThanh?.tongSoKhach ?? 0 )".currencyFormatting()
        
        data = item.rpTheoGio ?? [RPTheoGio]()
        xuLyDuLieuTheoGio()
        setupHorizontalBarChart()
        
    }
    @IBAction func reloadPressed(_ sender: Any) {
        actionReload?()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setupHorizontalBarChart() {
        
        var dataEntries = [BarChartDataEntry]()
        for x in 0..<data.count {
            dataEntries.append(BarChartDataEntry(x: Double(x), y: Double(((data[x].tongTienCK ?? 0) + (data[x].tongTienMat ?? 0)))))
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
        barChartView.rightAxis.drawLabelsEnabled = 	false
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
        let e = data.itemAtIndex(index: Int(entry.x))
        lbTheoNgayNgay.text = "Giờ từ: \(e?.date ?? ""):00 đến \(e?.date ?? ""):59 "
        let tong: Int = (e?.tongTienCK ?? 0) + (e?.tongTienMat ?? 0)
        lbTNTongDoanhThu.text = "Doanh thu: "+"\(tong)".currencyFormatting()
        lbTNTongCK.text = "• Chuyển khoản: " + "\(e?.tongTienCK ?? 0)".currencyFormatting()
        lbTNTongTienMat.text = "• Tiền mặt: " + "\((e?.tongTienMat ?? 0))".currencyFormatting()
        lbTNTongHoaDon.text = "Hoá đơn: " + "\((e?.tongHoaDon ?? 0))".currencyFormatting()
        lbTNTongSoKhach.text = "Số khách: " + "\((e?.tongKhach ?? 0))".currencyFormatting()
    }
    func xuLyDuLieuTheoGio(){
        for x in 0..<data.count {
            var tongHoaDon: Int = 0
            var tongTienMat: Int = 0
            var tongTienCK: Int = 0
            var tongKhach: Int = 0
            
            guard let e = data.itemAtIndex(index: x)?.value else {continue}
            
            tongHoaDon = e.count
            for y in 0..<e.count {
                let e1 = e[y]
                if e1.type == 1 {
                    tongTienMat += e1.total ?? 0
                }
                if e1.type == 2 {
                    tongTienCK += e1.total ?? 0
                }
                tongKhach += e1.person ?? 0
            }
            data[x].tongKhach = tongKhach
            data[x].tongHoaDon = tongHoaDon
            data[x].tongTienCK = tongTienCK
            data[x].tongTienMat = tongTienMat
        }
    }
    func setupDataGioDauTIen(){
        let e = data.itemAtIndex(index: 0)
        
        lbTheoNgayNgay.text = "Giờ từ: \(e?.date ?? ""):00 đến \(e?.date ?? ""):59 "
        let tong: Int = (e?.tongTienCK ?? 0) + (e?.tongTienMat ?? 0)
        lbTNTongDoanhThu.text = "Doanh thu: "+"\(tong)".currencyFormatting()
        lbTNTongCK.text = "• Chuyển khoản:" + "\(e?.tongTienCK ?? 0)".currencyFormatting()
        lbTNTongTienMat.text = "• Tiền mặt:" + "\((e?.tongTienMat ?? 0))".currencyFormatting()
        lbTNTongHoaDon.text = "Hoá đơn: " + "\((e?.tongHoaDon ?? 0))".currencyFormatting()
        lbTNTongSoKhach.text = "Số khách: " + "\((e?.tongKhach ?? 0))".currencyFormatting()
    }
}
