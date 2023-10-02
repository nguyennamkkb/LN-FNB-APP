//
//  FCategory.swift
//  LN FNB
//
//  Created by namnl on 03/10/2023.
//

import Foundation
import ObjectMapper

class FCategory: Mappable {
    var id: Int?
    var name: String?
    var user_id: Int?
    var createAt: String?
    var updateAt: String?
    var status: Int?
    var cksRequest: String?
    var timeRequest: Int?
    
    init(){
        sign()
    }
    init (user_id: Int, name: String){
        self.user_id = user_id
        self.name = name
        sign()
    }
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
        user_id <- map["user_id"]
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
