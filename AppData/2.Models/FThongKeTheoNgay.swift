//
//  FThongKeTheoNgay.swift
//  LN FNB
//
//  Created by Mac mini on 09/12/2023.
//

import Foundation
import ObjectMapper

class FThongKeTheoNgay: Mappable {
    var tongSoDonHang: Int?
    var tongTienMat: Int?
    var tongTienCK: Int?
    var tongSoKhach: Int?
    var tongDonShip: Int?
    var rpTheoNgay: [RPTheoNgay]?
    
    
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
        rpTheoNgay <- map["rpTheoNgay"]
    }
}

class RPTheoNgay: Mappable {
    var date: String?
    var value: [RPValueNgay]?
   
    
    
    init(){
    }
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        date <- map["date"]
        value <- map["value"]
       
    }
}
class RPValueNgay: Mappable {
    var person: Int?
    var ship: Int?
    var total: Int?
    var type: Int?
    

    
    
    init(){
    }
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        person <- map["person"]
        ship <- map["ship"]
        total <- map["total"]
        type <- map["type"]
    }
}
