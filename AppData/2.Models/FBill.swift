//
//  FBill.swift
//  LN FNB
//
//  Created by namnl on 15/10/2023.
//

import Foundation
import ObjectMapper

class FBill: Mappable {
    var id: Int?
    var user_id: Int?
    var order_id: Int?
    var type: Int?
    var last_total: Int?
    var person: Int?
    var table: String?
    var note: String?
    var voucher: String?
    var order: FOrder?
    var createAt: String?
    var updateAt: String?
    var status: Int?
    var cksRequest: String?
    var timeRequest: Int?
    
    init(){
        sign()
    }
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        user_id <- map["user_id"]
        order_id <- map["order_id"]
        type <- map["type"]
        last_total <- map["last_total"]
        person <- map["person"]
        table <- map["table"]
        note <- map["note"]
        voucher <- map["voucher"]
        order <- map["order"]
        createAt <- map["createAt"]
        updateAt <- map["updateAt"]
        status <- map["status"]
        cksRequest <- map["cksRequest"]
        timeRequest <- map["timeRequest"]

    }
    func sign(){
        let mili = Common.getMilisecondNow()
        self.cksRequest = Common.MD5(string: Common.KEY_APP+"\(mili)")
        self.timeRequest = mili
    }
}
