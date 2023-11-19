//
//  FThongKeHomNay.swift
//  LN FNB
//
//  Created by namnl on 16/11/2023.
//

import Foundation
import ObjectMapper

class FThongKeHomNay: Mappable {
    var chuaHoanThanh: ChuaHoanThanh?
    var daHoanThanh: DaHoanThanh?
    var rpTheoGio: [RPTheoGio]?
    
    
    init(){
    }
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        chuaHoanThanh <- map["chuaHoanThanh"]
        daHoanThanh <- map["daHoanThanh"]
        rpTheoGio <- map["rpTheoGio"]
    }
}

class ChuaHoanThanh: Mappable {
    
    var tongDangPhucVu: Int?
    var tongDatTruoc: Int?
    var tongShip: Int?
    var tongKhach: Int?
    var tongThuDuTinh: Int?
    
    init(){
    }
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        tongDangPhucVu <- map["tongDangPhucVu"]
        tongDatTruoc <- map["tongDatTruoc"]
        tongShip <- map["tongShip"]
        tongKhach <- map["tongKhach"]
        tongThuDuTinh <- map["tongThuDuTinh"]
    }
}

class DaHoanThanh: Mappable {
    
    var tongSoDonHang: Int?
    var tongTienMat: Int?
    var tongTienCK: Int?
    var tongSoKhach: Int?
    var tongDonShip: Int?
    
    init(){
    }
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        tongSoDonHang <- map["tongSoDonHang"]
        tongTienMat <- map["tongTienMat"]
        tongTienCK <- map["tongTienCK"]
        tongSoKhach <- map["tongSoKhach"]
        tongDonShip <- map["tongDonShip"]
    }
}
class RPTheoGio: Mappable {
    
    var date: String?
    var value: [GiaTriTheoGio]?
    var tongTienMat: Int?
    var tongTienCK: Int?
    var tongHoaDon: Int?
    var tongKhach: Int?

    
    init(){
    }
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        date <- map["date"]
        value <- map["value"]
        tongTienMat <- map["tongTienMat"]
        tongTienCK <- map["tongTienCK"]
        tongHoaDon <- map["tongHoaDon"]
        tongKhach <- map["tongKhach"]
    }
}

class GiaTriTheoGio: Mappable {
    
    var total: Int?
    var type: Int?
    var person: Int?
    var ship: Int?

    
    init(){
    }
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        total <- map["total"]
        type <- map["type"]
        person <- map["person"]
        ship <- map["ship"]
   
    }
}
