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
    var total: Int?
    var table: String?
    var list_item: String?
    var note: String?
    var person: Int?
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
        total <- map["total"]
        table <- map["table"]
        list_item <- map["list_item"]
        note <- map["note"]
        person <- map["person"]
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
